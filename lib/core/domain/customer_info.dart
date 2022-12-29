import 'package:oulun_energia_mobile/core/domain/usage_place.dart';

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
