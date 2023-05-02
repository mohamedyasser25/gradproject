import '../../../../../../shared/models/JobApplicationModel.dart';

abstract class ApplicantionsStatusStates {}

class ApplicantionsStatusInitialState extends ApplicantionsStatusStates {}

class UserApplicationsSuccessState extends ApplicantionsStatusStates {
  List<JobApplicationModel> apps;

  UserApplicationsSuccessState(this.apps);
}

class UserApplicationsErrorState extends ApplicantionsStatusStates {
  String err;

  UserApplicationsErrorState(this.err);
}
