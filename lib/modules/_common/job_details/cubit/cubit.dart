import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/modules/_common/job_details/cubit/states.dart';

import '../../../../shared/models/JobApplicationModel.dart';

class JobDetailsCubit extends Cubit<JobDetailsStates> {
  JobDetailsCubit() : super(JobDetailsInitialState());

  static JobDetailsCubit get(context) => BlocProvider.of(context);

  void applyForjob({
    required String jobId,
  }) {
    print(jobId);
    JobApplicationModel model = JobApplicationModel(
      jobID: jobId,
    );
    saveJobApplication(model);
  }

  void saveJobApplication(JobApplicationModel M) {
    FirebaseFirestore.instance
        .collection('jobApplication')
        .add(M.toMap())
        .then((value) {
      emit(JobApplySuccessState());
    }).catchError((error) {
      emit(JobApplyErorrState(error.toString()));
    });
  }
}
