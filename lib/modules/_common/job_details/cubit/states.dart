abstract class JobDetailsStates {}

class JobDetailsInitialState extends JobDetailsStates {}

class JobApplySuccessState extends JobDetailsStates {}

class JobApplyErorrState extends JobDetailsStates {
  final String error;
  JobApplyErorrState(this.error);
}
