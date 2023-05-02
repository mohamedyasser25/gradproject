import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gp2023/shared/caching/cache_helper.dart';

class JobApplicationModel {
  String? jobID;
  DateTime? date;
  String? status;
  String? applicantID;

  JobApplicationModel({
    this.jobID,
    this.date,
    this.status,
    this.applicantID,
  });

  factory JobApplicationModel.fromJson(Map<String, dynamic> json) {
    return JobApplicationModel(
      jobID: json['jobID'],
      date: (json['date'] as Timestamp).toDate(),
      status: json['status'],
      applicantID: json['applicantID'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'jobID': jobID,
      'date': DateTime.now(),
      'status': "pending",
      'applicantID': CacheHelper.getData(key: "uId"),
    };
  }
}
