class ExperienceModel {
  String companyName;
  String position;
  String startDate;
  String endDate;
  String uId;

  ExperienceModel({
    required this.companyName,
    required this.position,
    required this.startDate,
    required this.endDate,
    required this.uId,
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      companyName: json['companyName'],
      position: json['position'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      uId: json['uId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'companyName': companyName,
      'position': position,
      'startDate': startDate,
      'endDate': endDate,
      'uId': uId
    };
  }
}
