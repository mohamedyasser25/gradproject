abstract class ApplicantStates {}

class ApplicantInitialState extends ApplicantStates {}

class ApplicantUserStringState extends ApplicantStates {}

class ApplicantChangeBottomNavBarState extends ApplicantStates {}

class ApplicantGetUserErrorState extends ApplicantStates {
  final String error;

  ApplicantGetUserErrorState(this.error);
}
