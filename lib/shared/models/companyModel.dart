import 'package:gp2023/shared/caching/cache_helper.dart';

class CompanyModel {
  String name;
  String email;
  String city;
  String country;
  int taxNumber;
  String description;
  String phone;
  String? hrID;

  CompanyModel({
    required this.name,
    required this.email,
    required this.city,
    required this.country,
    required this.taxNumber,
    required this.description,
    required this.phone,
    this.hrID,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      name : json['name'],
      email : json['email'],
      city : json['city'],
      country : json['country'],
      taxNumber : json['taxNumber'],
      description : json['description'],
      phone : json['phone'],
      hrID : json['hrID'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'city': city,
      'country': country,
      'taxNumber': taxNumber,
      'description': description,
      'phone': phone,
      'hrID': CacheHelper.getData(key: 'uId')
    };
  }
}
