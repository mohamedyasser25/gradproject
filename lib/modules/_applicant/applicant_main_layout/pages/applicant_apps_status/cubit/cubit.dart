import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/modules/_applicant/applicant_main_layout/pages/applicant_apps_status/cubit/states.dart';
import 'package:gp2023/shared/caching/cache_helper.dart';

import '../../../../../../shared/models/JobApplicationModel.dart';

class ApplicantionsStatesCubit extends Cubit<ApplicantionsStatusStates> {
  ApplicantionsStatesCubit() : super(ApplicantionsStatusInitialState());

  static ApplicantionsStatesCubit get(context) => BlocProvider.of(context);

  getUserApplications() {
    FirebaseFirestore.instance
        .collection('jobApplication')
        .where('applicantID', isEqualTo: CacheHelper.getData(key: 'uId'))
        .get()
        .then((value) {
      List<JobApplicationModel> apps =
          value.docs.map((e) => JobApplicationModel.fromJson(e.data())).toList();
      emit(UserApplicationsSuccessState(apps));
    }).catchError((error) {
      print(error.toString());
      emit(UserApplicationsErrorState(error.toString()));
    });
  }

  getJob(JobApplicationModel app) async {
    final x = await FirebaseFirestore.instance.collection('jobs').doc(app.jobID).get();
    return x.data();
  }

  getJobApp(JobApplicationModel app) async {
    final x = await FirebaseFirestore.instance
        .collection('jobApplication')
        .where('applicantID', isEqualTo: app.applicantID)
        .where('jobID', isEqualTo: app.jobID)
        .get();

    return x.docs[0].data();
  }

  getJobAppId(JobApplicationModel app) async {
    final jobAppData = await FirebaseFirestore.instance
        .collection('jobApplication')
        .where('applicantID', isEqualTo: app.applicantID)
        .where('jobID', isEqualTo: app.jobID)
        .get();

    return jobAppData.docs[0].id;
  }

  getRepliedInterviewDate(String jobAppId) async {
    final x = await FirebaseFirestore.instance
        .collection('interview')
        .where('jobApplicationID', isEqualTo: jobAppId)
        .get();

    return x.docs[0].data()['interviewDate'];
  }

  getRepliedInterviewTime(String jobAppId) async {
    final x = await FirebaseFirestore.instance
        .collection('interview')
        .where('jobApplicationID', isEqualTo: jobAppId)
        .get();

    return x.docs[0].data()['interviewTime'];
  }

  getRepliedFeedback(String jobAppId) async {
    final x = await FirebaseFirestore.instance
        .collection('feedback')
        .where('jobApplicationID', isEqualTo: jobAppId)
        .get();
    print('##### ${x.docs[0].data()}');

    return x.docs[0].data()['feedback'];
  }

  getRepliedReport(String jobAppId) async {
    final x = await FirebaseFirestore.instance
        .collection('finalReport')
        .where('jobApplicationID', isEqualTo: jobAppId)
        .get();

    return x.docs[0].data()['finalReport'];
  }
}
