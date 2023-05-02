abstract class HrRegisterStates {}

class HrRegisterInitialState extends HrRegisterStates {}

class HrRegisterLoadingState extends HrRegisterStates {}

class HrRegisterSuccessState extends HrRegisterStates {}

class HrRegisterErrorState extends HrRegisterStates {
  final String error;

  HrRegisterErrorState(this.error);
}

class HrCreateUserSuccessState extends HrRegisterStates {}

class HrCreateUserErrorState extends HrRegisterStates {
  final String error;

  HrCreateUserErrorState(this.error);
}

class HrDataChangeCityState extends HrRegisterStates {}

class HrDataChangeCountryState extends HrRegisterStates {}
