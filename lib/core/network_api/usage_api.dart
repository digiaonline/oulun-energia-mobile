import 'dart:convert';
import 'package:oulun_energia_mobile/core/domain/usage.dart';
import 'package:oulun_energia_mobile/core/domain/usage_place.dart';
import 'package:oulun_energia_mobile/core/domain/user_auth.dart';
import 'package:oulun_energia_mobile/core/enums.dart';
import 'package:oulun_energia_mobile/core/network_api/network_api.dart';
import 'package:xml2json/xml2json.dart';

class UsageApi extends RestApiBase {
  final String _electricUsagePath;
  final String _districtHeatingPath;

  UsageApi(super.authentication, super.baseUrl)
      : _electricUsagePath = "$baseUrl/api/v2/kulutus",
        _districtHeatingPath = "$baseUrl/api/v3/kaukolampo/kulutus";

  Future<List<Usage>> getElectricUsage(
      UserAuth? userAuth,
      UsagePlace? usagePlace,
      String from,
      String to,
      UsageInterval usageInterval) async {
    if (userAuth == null || usagePlace == null) {
      return [];
    }

    String interval = usageInterval.name.toUpperCase();
    String usageType = usagePlace.type == UsageType.electric
        ? _electricUsagePath
        : _districtHeatingPath;
    String uri =
        '$usageType/${usagePlace.id}/${usagePlace.network}/$from/$to/$interval/${userAuth.oeToken}';

    var content = await get(uri);

    if (content == null) {
      return [];
    }

    Map<String, dynamic> jsonObj = xmlToJson(content);

    bool hasReadings = jsonObj['s:Envelope']['s:Body']
                    ['FetchMeteringDataWSResponse']['FetchMeteringDataWSResult']
                ['a:Readings']
            .toString() !=
        'null';

    if (!hasReadings) {
      return [];
    }

    List<dynamic> usages = [];

    Map<String, dynamic> readings = jsonObj['s:Envelope']['s:Body']
            ['FetchMeteringDataWSResponse']['FetchMeteringDataWSResult']
        ['a:Readings'];

    try {
      var readingObj = readings['a:ReadingData'];
      String type = readingObj.runtimeType.toString();

      switch (type) {
        case '_InternalLinkedHashMap<String, dynamic>':
          usages = [readingObj];
          break;
        case 'List<dynamic>':
          usages = readingObj;
          break;
        default:
          throw TypeError();
      }

      // TODO Should we include approximated values also, or just measured?

      return usages
          .map((reading) => Usage.fromJson(reading, usageInterval))
          .toList()
          .where((usage) => usage.statusCode == StatusCode.measured)
          .toList();
    } catch (e) {
      return [];
    }
  }

  String dateToUtcString(DateTime dateTime) =>
      dateTime.toUtc().toIso8601String();

  Map<String, dynamic> xmlToJson(String content) {
    final xmlTransformer = Xml2Json();
    xmlTransformer.parse(content);
    return jsonDecode(xmlTransformer.toParker());
  }
}
