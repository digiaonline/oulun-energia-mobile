class Contract {
  final String? startDate;
  final String? endDate;

  Contract({this.startDate, this.endDate});

  Map toJson() {
    return {'start_date': startDate, 'end_date': endDate};
  }

  static Contract fromJson(Map<String, dynamic> json) {
    return Contract(startDate: json['start_date'], endDate: json['end_date']);
  }
}
