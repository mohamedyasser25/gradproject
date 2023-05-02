import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class JobModel {
  String? id;
  String? companyId;
  String? jobTitle;
  String? jobDescription;
  num? salary;
  DateTime? startDate;
  DateTime? endDate;
  String? jobType;
  String? experienceYears;
  String? position;
  String? jobIcon;
  List<dynamic>? jobSkills;
  List<dynamic>? jobRequirement;

  JobModel({
    this.jobTitle,
    this.jobDescription,
    this.salary,
    this.startDate,
    this.endDate,
    this.jobType,
    this.position,
    this.experienceYears,
    this.jobSkills,
    this.jobRequirement,
    this.companyId,
    this.jobIcon,
  });

  JobModel.fromJson(Map<String, dynamic> json) {
    jobTitle = json['jobTitle'];
    jobDescription = json['jobDescription'];
    jobType = json['jobType'];
    salary = json['salary'];
    position = json['position'];
    jobRequirement = json['jobRequirement'];
    startDate = (json['startDate'] as Timestamp).toDate();
    endDate = (json['endDate'] as Timestamp).toDate();
    experienceYears = json['experienceYears'];
    jobSkills = json['jobSkills'];
    companyId = json['companyID'];
    jobIcon = json['JobIcon'] ?? icons[Random().nextInt(5)];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'jobTitle': jobTitle,
      'jobDescription': jobDescription,
      'jobType': jobType,
      'salary': salary,
      'position': position,
      'jobRequirement': jobRequirement,
      'startDate': startDate,
      'endDate': endDate,
      'experienceYears': experienceYears,
      'jobSkills': jobSkills,
      'companyID': companyId,
      'JobIcon': jobIcon ?? icons[Random().nextInt(5)],
    };
  }
}

var icons = [
  'assets/IconsImage/certicraft.png',
  'assets/IconsImage/beanworks.jpeg',
  'assets/IconsImage/mailchimp.jpeg',
  'assets/IconsImage/mozila.png',
  'assets/IconsImage/reddit.jpeg',
];
