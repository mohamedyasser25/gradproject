abstract class WorkableRegisterStates {}

class WorkableRegisterInitialState extends WorkableRegisterStates {}

class WorkableRegisterLoadingState extends WorkableRegisterStates {}

class WorkableRegisterSuccessState extends WorkableRegisterStates {}

class WorkableRegisterErrorState extends WorkableRegisterStates {
  final String error;

  WorkableRegisterErrorState(this.error);
}

class WorkableCreateUserSuccessState extends WorkableRegisterStates {}

class WorkableCreateUserErrorState extends WorkableRegisterStates {
  final String error;

  WorkableCreateUserErrorState(this.error);
}

class WorkableRegisterChangePasswordVisibilityState
    extends WorkableRegisterStates {}

class WorkableChangeGenderIsMaleState extends WorkableRegisterStates {}

class WorkableChangeRoleIsApplicantState extends WorkableRegisterStates {}
