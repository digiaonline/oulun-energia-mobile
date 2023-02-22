import 'dart:convert';

import 'package:oulun_energia_mobile/core/domain/customer_info.dart';

class UserAuth {
  final bool firstLogin;
  final String oeToken;
  final String? username;
  final String? password;
  final CustomerInfo customerInfo;

  UserAuth(
      {required this.firstLogin,
      required this.oeToken,
      required this.customerInfo,
      this.username,
      this.password});

  Map<String, dynamic> toJsonMap() {
    var map = {
      'first_login': firstLogin,
      'etoken': oeToken,
      'customer_info': customerInfo.toMap()
    };
    if (username != null) {
      map['username'] = base64Encode(utf8.encode(username!));
    }
    if (password != null) {
      map['password'] = base64Encode(utf8.encode(password!));
    }
    return map;
  }

  static UserAuth fromJson(Map<String, dynamic> json,
      {String? username, String? password}) {
    return UserAuth(
        firstLogin: json['first_login'],
        oeToken: json['etoken'],
        customerInfo: CustomerInfo.fromJson(json['customer_info']),
        username: username ?? utf8.decode(base64Decode(json['username'])),
        password: password ?? utf8.decode(base64Decode(json['password'])));
  }
}
