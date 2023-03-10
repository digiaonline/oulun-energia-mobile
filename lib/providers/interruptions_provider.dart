import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oulun_energia_mobile/core/authentication/authentication.dart';
import 'package:oulun_energia_mobile/core/domain/interruption_notice.dart';
import 'package:oulun_energia_mobile/core/network_api/interruptions_api.dart';
import 'package:oulun_energia_mobile/flavors.dart';

final interruptionsProvider =
    FutureProvider.autoDispose<List<InterruptionNotice>>((ref) async {
  var interruptionsApi = InterruptionsApi(Authentication(), F.baseUrl);

  try {
    var interruptionNotices = await interruptionsApi.getInterruptionNotices();
    return interruptionNotices;
  } catch (e) {
    return [];
  }
});
