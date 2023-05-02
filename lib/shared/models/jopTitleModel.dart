class SkillsModel {
  List<SkillsDataModel> data;

  SkillsModel({required this.data});

  factory SkillsModel.fromJson(Map<String, dynamic> json) {
    final data = <SkillsDataModel>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(SkillsDataModel.fromJson(v));
      });
    }
    return SkillsModel(data: data);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class SkillsDataModel {
  int id;
  String name;

  SkillsDataModel({required this.id,required  this.name});

  factory SkillsDataModel.fromJson(Map<String, dynamic> json) {
    return SkillsDataModel(
      id: json['Id'],
      name: json['Name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    return data;
  }
}
