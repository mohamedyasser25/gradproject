import 'package:gp2023/shared/caching/cache_helper.dart';

class CVModel {
  String jobTitle;
  String degree;
  String city;
  String gender;
  String nationality;
  String dateOfBirth;
  String uId;
  String email;
  String phone;
  String name;



  CVModel({
    required this.jobTitle,
    required this.degree,
    required this.city,
    required this.gender,
    required this.nationality,
    required this.dateOfBirth,
    required this.uId,
    required this.email,
    required this.phone,
    required this.name,
  });

  factory CVModel.fromJson(Map<String, dynamic> json) {
    return CVModel(
      jobTitle : json['jobTitle'],
      degree : CacheHelper.getData(key: 'degree') ?? '?',
      city : json['city'],
      gender : json['gender'],
      nationality : json['nationality'],
      dateOfBirth : json['dateOfBirth'],
      uId : json['uId'],
      email : json['email'],
      name : json['name'],
      phone : json['phone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'jobTitle': jobTitle,
      'degree': degree,
      'city': city,
      'gender': gender,
      'nationality': nationality,
      'dateOfBirth': dateOfBirth,
      'uId': uId,

      'name': name,
      'email': email,
      'phone': phone,

    };
  }
}
