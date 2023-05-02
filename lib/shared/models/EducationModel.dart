class EducationModel {
  String educationLevel;
  String university;
  String faculty;
  String startDate;
  String endDate;
  String uId;

  EducationModel({
    required this.educationLevel,
    required this.university,
    required this.faculty,
    required this.startDate,
    required this.endDate,
    required this.uId,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      educationLevel : json['educationLevel'],
      university : json['university'],
      faculty : json['faculty'],
      startDate : json['startDate'],
      endDate : json['endDate'],
      uId : json['uId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'educationLevel': educationLevel,
      'university': university,
      'faculty': faculty,
      'startDate': startDate,
      'endDate': endDate,
      'uId': uId
    };
  }
}
