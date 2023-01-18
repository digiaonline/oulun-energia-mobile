import 'dart:convert';

import 'package:oulun_energia_mobile/core/domain/usage_place.dart';
import 'package:oulun_energia_mobile/core/enums.dart';

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

  Map<UsageType, List<UsagePlace>> getUsagePlacesByUsageType() {
    Map<UsageType, List<UsagePlace>> placesByType = {};
    List<UsageType> usageTypes =
        UsageType.values.where((type) => type != UsageType.missing).toList();

    for (UsageType usageType in usageTypes) {
      List<UsagePlace> filteredPlaces = usagePlaces
          .where((usagePlace) => usagePlace.type == usageType)
          .toList();

      if (filteredPlaces.isNotEmpty) {
        placesByType[usageType] = filteredPlaces;
      }
    }

    return placesByType;
  }

  String toJson() {
    var map = toMap();
    return jsonEncode(map);
  }

  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'usage_places': usagePlaces,
      'company_name': companyName,
      'email': email,
      'name': name,
      'phone': phone,
      'postcode': postcode,
      'postplace': postPlace,
      'street': street,
      'customer_codes': customerCodes
    };
  }

  factory CustomerInfo.fromJson(Map<String, dynamic> json) {
    List<String> customerCodes = [];
    for (String customerCode in json['customer_codes']) {
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
