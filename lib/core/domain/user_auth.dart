import 'package:oulun_energia_mobile/core/domain/customer_info.dart';

class UserAuth {
  final bool firstLogin;
  final String oeToken;
  final CustomerInfo customerInfo;

  UserAuth(
      {required this.firstLogin,
      required this.oeToken,
      required this.customerInfo});

  Map<String, dynamic> toJsonMap() {
    var map = {
      'first_login': firstLogin,
      'etoken': oeToken,
      'customer_info': customerInfo.toMap()
    };
    return map;
  }

  static UserAuth fromJson(Map<String, dynamic> json) {
    return UserAuth(
        firstLogin: json['first_login'],
        oeToken: json['etoken'],
        customerInfo: CustomerInfo.fromJson(json['customer_info']));
  }
}
