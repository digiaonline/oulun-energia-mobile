import 'dart:convert';
import 'dart:io';

import 'package:oulun_energia_mobile/core/domain/user_auth.dart';
import 'package:oulun_energia_mobile/core/network_api/network_api.dart';

class AuthenticationApi extends RestApiBase {
  final String _loginPath;
  final String _tokenPath;

  AuthenticationApi(super.authentication, super.baseUrl)
      : _loginPath = "$baseUrl/api/v1/etili/login",
        _tokenPath = "$baseUrl/api/v1/token";

  Future<String?> requestToken() async {
    var user = "oe_app";
    var passwd = "9d1d5K8inM7774ji0m";
    var headers =
        await getAuthenticationHeaders(username: user, passwd: passwd);
    RestApiResponse response =
        await restClient.get(Uri.parse(_tokenPath), headers: headers);
    if (response.response?.statusCode == HttpStatus.ok) {
      var content = await response.bodyContent();
      var token = jsonDecode(content)["token"];
      return token;
    }
    return null;
  }

  Future<UserAuth?> login(
      {required String username, required String password}) async {
    var headers = await getAuthenticationHeaders();
    var response = await restClient.post(
      Uri.parse(_loginPath),
      headers: headers,
      body: ("${Uri.encodeQueryComponent("tunnus")}=${Uri.encodeQueryComponent(username)}&"
          "${Uri.encodeQueryComponent("salasana")}=${Uri.encodeQueryComponent(password)}"),
    );
    if (response.response?.statusCode == HttpStatus.ok) {
      var content = await response.bodyContent();
      var data = jsonDecode(content);
      return UserAuth.fromJson(data);
    }

    return null;
  }
}
