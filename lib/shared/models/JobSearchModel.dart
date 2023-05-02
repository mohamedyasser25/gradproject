import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class JobSearchModel {
  final String id;
  final String companyId;
  final String jobTitle;
  final String jobDescription;
  final String jobType;
  final String jobIcon;
  final double salary;
  final String role;
  final DateTime startDate;
  final DateTime endDate;

  // constructor
  JobSearchModel({
    required this.id,
    required this.companyId,
    required this.jobIcon,
    required this.jobTitle,
    required this.jobDescription,
    required this.jobType,
    required this.role,
    required this.salary,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toJson() => {
        'ID': id,
        'JobIcon': jobIcon ?? icons[Random().nextInt(5)],
        'Company_ID': companyId,
        'JobTitle': jobTitle,
        'JobDescription': jobDescription,
        'JobType': jobType,
        'Salary': salary,
        'Role': role,
        'StartDate': startDate,
        'EndDate': endDate,
      };

  // function to convert Json to Job object.
  static JobSearchModel fromJson(Map<String, dynamic> json) => JobSearchModel(
        id: json['ID'],
        jobIcon: json['JobIcon'] ?? icons[Random().nextInt(5)],
        companyId: json['Company_ID'],
        jobTitle: json['JobTitle'],
        jobDescription: json['JobDescription'],
        jobType: json['JobType'],
        salary: json['Salary'].toDouble(),
        role: json['Role'],
        startDate: (json['StartDate'] as Timestamp).toDate(),
        endDate: (json['EndDate'] as Timestamp).toDate(),
      );
}

var icons = [
  'assets/IconsImage/certicraft.png',
  'assets/IconsImage/beanworks.jpeg',
  'assets/IconsImage/mailchimp.jpeg',
  'assets/IconsImage/mozila.png',
  'assets/IconsImage/reddit.jpeg',
];
