import '../../../../shared/models/job_model.dart';

abstract class HrStates {}

class HrInitialState extends HrStates {}

class HrUserStringState extends HrStates {}

class HrChangeBottomNavBarState extends HrStates {}

class HrChangePositonsValueState extends HrStates {}

class HrChangeJobTypeState extends HrStates {}

class HrChangeJobTitleState extends HrStates {}

class HrChangeExperienceValueState extends HrStates {}

class AppChangeBottomSheetState extends HrStates {}

class HrSaveSuccessState extends HrStates {}

class HrGetUserErrorState extends HrStates {
  final String error;

  HrGetUserErrorState(this.error);
}

class HrGetJobsSuccessState extends HrStates {
  final List<JobModel> jobs;

  HrGetJobsSuccessState(this.jobs);
}

class HrGetJobsErrorState extends HrStates {
  final String error;

  HrGetJobsErrorState(this.error);
}
