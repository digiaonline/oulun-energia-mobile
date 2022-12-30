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
      DateTime from,
      DateTime to,
      UsageInterval usageInterval) async {
    if (userAuth == null || usagePlace == null) {
      return [];
    }

    var fromUtc = dateToUtcString(from);
    var toUtc = dateToUtcString(to);
    var interval = usageInterval.name.toUpperCase();

    var uri =
        '$_electricUsagePath/${usagePlace.id}/${usagePlace.network}/$fromUtc/$toUtc/$interval/${userAuth.oeToken}';

    var content = await get(uri);

    if (content == null) {
      return [];
    }

    var json = xmlToJson(content);

    List<dynamic> readings = json['s:Envelope']['s:Body']
            ['FetchMeteringDataWSResponse']['FetchMeteringDataWSResult']
        ['a:Readings']['a:ReadingData'];

    return readings
        .map((reading) => Usage.fromJson(reading, usageInterval))
        .toList();
  }

  String dateToUtcString(DateTime dateTime) =>
      dateTime.toUtc().toIso8601String();

  Map<String, dynamic> xmlToJson(String content) {
    final xmlTransformer = Xml2Json();
    xmlTransformer.parse(content);
    return jsonDecode(xmlTransformer.toParker());
  }
}
