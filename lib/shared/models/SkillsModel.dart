class SkillModel {
  String skillName;
  String uId;

  SkillModel({
    required this.skillName,
    required this.uId,
  });

  factory SkillModel.fromJson(Map<String, dynamic> json) {
    return SkillModel(
      skillName: json['skillName'],
      uId: json['uId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'skillName': skillName, 'uId': uId};
  }
}
