import 'package:gp2023/shared/caching/cache_helper.dart';

class WorkableUserModel {
  String name;
  String email;
  String phone;
  String uId;
  bool isMale;
  bool isEmailVerified;
  String password;
  bool isApplicant;

  WorkableUserModel({
    required this.email,
    required this.name,
    required this.phone,
    required this.uId,
    required this.isMale,
    required this.isEmailVerified,
    required this.isApplicant,
    required this.password,
  });

  factory WorkableUserModel.fromJson(Map<String, dynamic> json) {
    return WorkableUserModel(
    email: json['email'],
    name: json['name'],
    phone: json['phone'],
    uId: CacheHelper.getData(key: 'uId'),
    isMale: json['isMale'],
    isEmailVerified: json['isEmailVerified'],
    password: json['password'],
    isApplicant: json['isApplicant'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'isMale': isMale,
      'isEmailVerified': isEmailVerified,
      'uId': uId,
      'password': password,
      'isApplicant': isApplicant
    };
  }
}
