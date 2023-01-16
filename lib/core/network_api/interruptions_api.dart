import 'dart:convert';
import 'package:oulun_energia_mobile/core/domain/interruption_notice.dart';
import 'package:oulun_energia_mobile/core/network_api/network_api.dart';

class InterruptionsApi extends RestApiBase {
  InterruptionsApi(super.authentication, super.baseUrl);

  Future<List<InterruptionNotice>> getInterruptionNotices() async {
    String uri = '$baseUrl/api/v1/keskeytys';

    Map<String, String> headers = await getAuthenticationHeaders();
    var content = await restClient.getContent(uri, headers);

    if (content == null) {
      return [];
    }

    List<dynamic> interruptions = jsonDecode(content);

    return interruptions
        .map((json) => InterruptionNotice.fromJson(json))
        .toList();
  }
}
