import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/modules/_hr/job_applications/cubit/states.dart';

import '../../../../shared/models/JobApplicationModel.dart';
import '../../../../shared/models/job_model.dart';

class JobApplicationsCubit extends Cubit<JobApplicationsState> {
  JobApplicationsCubit() : super(JobApplicationsInitialState());

  static JobApplicationsCubit get(context) => BlocProvider.of(context);

  getJobApplications(JobModel job) {
    FirebaseFirestore.instance
        .collection('jobApplication')
        .where('jobID', isEqualTo: job.id)
        .get()
        .then((value) {
      List<JobApplicationModel> apps =
          value.docs.map((e) => JobApplicationModel.fromJson(e.data())).toList();
      emit(JobApplicationsSuccessState(apps));
    }).catchError((error) {
      print(error.toString());
      emit(JobApplicationsErrorState(error.toString()));
    });
  }

  Future<String> getApplicantName(JobApplicationModel app) async {
    String appName = await FirebaseFirestore.instance
        .collection('Applicant')
        .where('uId', isEqualTo: app.applicantID)
        .get()
        .then((value) => value.docs[0].data()['name']);

    return appName;
  }

  sendInterviewToApplicant(JobApplicationModel app, String interviewDate) async {
    FirebaseFirestore.instance
        .collection('jobApplication')
        .where('applicantID', isEqualTo: app.applicantID)
        .where('jobID', isEqualTo: app.jobID)
        .get()
        .then((value) {
      String jobAppId = value.docs.first.id;

      FirebaseFirestore.instance
          .collection('jobApplication')
          .doc(jobAppId)
          .update({'status': 'interview'});

      FirebaseFirestore.instance.collection('interview').add({
        'interviewDate': interviewDate,
        'jobApplicationID': jobAppId,
      });
    });
  }

  sendFeedbackToApplicant(JobApplicationModel app, String feedback) async {
    FirebaseFirestore.instance
        .collection('jobApplication')
        .where('applicantID', isEqualTo: app.applicantID)
        .where('jobID', isEqualTo: app.jobID)
        .get()
        .then((value) {
      String jobAppId = value.docs.first.id;

      FirebaseFirestore.instance
          .collection('jobApplication')
          .doc(jobAppId)
          .update({'status': 'feedback'});

      FirebaseFirestore.instance.collection('feedback').add({
        'feedback': feedback,
        'jobApplicationID': jobAppId,
      });
    });
  }

  sendFinalReportToApplicant(JobApplicationModel app, String report) {
    FirebaseFirestore.instance
        .collection('jobApplication')
        .where('applicantID', isEqualTo: app.applicantID)
        .where('jobID', isEqualTo: app.jobID)
        .get()
        .then((value) {
      String jobAppId = value.docs.first.id;

      FirebaseFirestore.instance
          .collection('jobApplication')
          .doc(jobAppId)
          .update({'status': 'finalReport'});

      FirebaseFirestore.instance.collection('finalReport').add({
        'report': report,
        'jobApplicationID': jobAppId,
      });
    });
  }

  getApplicantProfile(JobApplicationModel app) async {
    String profile = '';
    await FirebaseFirestore.instance
        .collection('cv')
        .where('uId', isEqualTo: app.applicantID)
        .get()
        .then((value) {
      Map profileMap = value.docs[0].data();

      profileMap.entries.forEach((element) {
        if (element.key != 'uId') {
          profile = '$profile\n- ${element.key} : ${element.value}';
        }
      });
    });
    return '$profile\n\n\n___';
  }

  getApplicantEducation(JobApplicationModel app) async {
    String allEducation = '';
    await FirebaseFirestore.instance
        .collection('Education')
        .where('uId', isEqualTo: app.applicantID)
        .get()
        .then((value) {
      for (var o in value.docs) {
        String education = '';
        o.data().entries.forEach((element) {
          if (element.key != 'uId') {
            education = '$education\n- ${element.key} : ${element.value}';
          }
        });
        allEducation = '$allEducation$education\n\n';
      }
    });
    return '$allEducation\n___';
  }

  getApplicantSkills(JobApplicationModel app) async {
    String allSkills = '';
    await FirebaseFirestore.instance
        .collection('ApplicantSkills')
        .where('uId', isEqualTo: app.applicantID)
        .get()
        .then((value) {
      for (var o in value.docs) {
        String skill = '';
        o.data().entries.forEach((element) {
          if (element.key != 'uId') {
            skill = '$skill\n- ${element.value}';
          }
        });
        allSkills = '$allSkills$skill';
      }
    });
    return '$allSkills\n\n';
  }

  getApplicantExperience(JobApplicationModel app) async {
    String allExp = '';
    await FirebaseFirestore.instance
        .collection('Experience')
        .where('uId', isEqualTo: app.applicantID)
        .get()
        .then((value) {
      for (var o in value.docs) {
        String exp = '';
        o.data().entries.forEach((element) {
          if (element.key != 'uId') {
            exp = '$exp\n- ${element.key} : ${element.value}';
          }
        });
        allExp = '$allExp$exp\n\n';
      }
    });
    return '$allExp\n___';
  }
}
