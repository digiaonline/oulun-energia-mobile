import 'dart:convert';
import 'dart:io';

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
      {String username = "mira.juola@icloud.com",
      String password = "Vaihda123456"}) async {
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

  Uri _buildUri(String uriPath, String user, String passwd) {
    var tokenUri = Uri.parse(uriPath);
    var host = tokenUri.host;
    var path = tokenUri.path;
    return Uri.parse("https://$user:$passwd@$host/$path");
  }
}

class UserAuth {
  final bool firstLogin;
  final String oeToken;
  final CustomerInfo customerInfo;

  UserAuth(
      {required this.firstLogin,
      required this.oeToken,
      required this.customerInfo});

  static UserAuth fromJson(Map<String, dynamic> json) {
    return UserAuth(
        firstLogin: json['first_login'],
        oeToken: json['etoken'],
        customerInfo: CustomerInfo.fromJson(json['customer_info']));
  }
}

class CustomerInfo {
  final String? companyName;
  final List<String> customerCodes;
  final String? email;
  final String firstName;
  final String lastName;
  final String? name;
  final String? phone;
  final String? postcode;
  final String? postPlace;
  final String? street;
  final List<UsagePlace> usagePlaces;

  CustomerInfo(
      {required this.customerCodes,
      required this.firstName,
      required this.lastName,
      required this.usagePlaces,
      this.companyName,
      this.email,
      this.name,
      this.phone,
      this.postcode,
      this.postPlace,
      this.street});

  static CustomerInfo fromJson(Map<String, dynamic> json) {
    List<String> customerCodes = [];
    for (var customerCode in json['customer_codes']) {
      customerCodes.add(customerCode);
    }

    List<UsagePlace> usagePlaces = [];
    for (var usagePlace in json['usage_places']) {
      usagePlaces.add(UsagePlace.fromJson(usagePlace));
    }

    return CustomerInfo(
        customerCodes: customerCodes,
        firstName: json['first_name'],
        lastName: json['last_name'],
        usagePlaces: usagePlaces,
        companyName: json['company_name'],
        email: json['email'],
        name: json['name'],
        phone: json['phone'],
        postcode: json['postcode'],
        postPlace: json['postplace'],
        street: json['street']);
  }
}

class UsagePlace {
  final bool isCompany;
  final String id;
  final String? network;
  final String? postCode;
  final String? postPlace;
  final String? street;
  final String? type;
  final List<Contract> contracts;

  UsagePlace({
    required this.id,
    required this.contracts,
    this.isCompany = false,
    this.network,
    this.postCode,
    this.postPlace,
    this.street,
    this.type,
  });

  static UsagePlace fromJson(Map<String, dynamic> json) {
    List<Contract> contracts = [];
    for (var contract in json['contracts']) {
      contracts.add(Contract.fromJson(contract));
    }

    return UsagePlace(
        isCompany: json['company'],
        id: json['id'],
        network: json['network'],
        postCode: json['postcode'],
        postPlace: json['postplace'],
        street: json['street'],
        type: json['type'],
        contracts: contracts);
  }
}

class Contract {
  final String? startDate;
  final String? endDate;

  Contract({this.startDate, this.endDate});

  static Contract fromJson(Map<String, dynamic> json) {
    return Contract(startDate: json['start_date'], endDate: json['end_date']);
  }
}
