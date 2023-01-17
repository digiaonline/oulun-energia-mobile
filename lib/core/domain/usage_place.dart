import 'package:oulun_energia_mobile/core/domain/contract.dart';
import 'package:oulun_energia_mobile/core/enums.dart';

class UsagePlace {
  final bool isCompany;
  final String id;
  final String? network;
  final String? postCode;
  final String? postPlace;
  final String? street;
  final String typeString;
  final List<Contract> contracts;

  UsagePlace({
    required this.id,
    required this.contracts,
    this.isCompany = false,
    this.network,
    this.postCode,
    this.postPlace,
    this.street,
    this.typeString = "sähkö",
  });

  get type => getUsageType(typeString);

  Map toJson() {
    var map = {
      'company': isCompany,
      'id': id,
      'network': network,
      'postcode': postCode,
      'postplace': postPlace,
      'street': street,
      'type': typeString,
      'contracts': contracts
    };
    return map;
  }

  factory UsagePlace.fromJson(Map<String, dynamic> json) {
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
        typeString: json['type'],
        contracts: contracts);
  }

  static getUsageType(String type) {
    switch (type.toLowerCase()) {
      case 'sähkö':
        return UsageType.electric;
      case 'kaukolämpö':
        return UsageType.districtHeating;
      default:
        return UsageType.missing;
    }
  }
}
