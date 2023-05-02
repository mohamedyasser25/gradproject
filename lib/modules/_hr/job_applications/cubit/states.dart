import '../../../../shared/models/JobApplicationModel.dart';

abstract class JobApplicationsState {}

class JobApplicationsInitialState extends JobApplicationsState {}

class JobApplicationsSuccessState extends JobApplicationsState {
  final List<JobApplicationModel> apps;

  JobApplicationsSuccessState(this.apps);
}

class JobApplicationsErrorState extends JobApplicationsState {
  final String error;

  JobApplicationsErrorState(this.error);
}
