import 'package:oulun_energia_mobile/core/domain/contract.dart';

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
