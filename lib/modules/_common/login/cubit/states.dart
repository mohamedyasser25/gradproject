abstract class WorkableLoginStates {}

class WorkableLoginInitialState extends WorkableLoginStates {}

class WorkableLoginLoadingState extends WorkableLoginStates {}

class WorkableLoginSuccessState extends WorkableLoginStates {
  final String uId;

  WorkableLoginSuccessState(this.uId);
}

class WorkableLoginErrorState extends WorkableLoginStates {
  final String error;

  WorkableLoginErrorState(this.error);
}

class WorkableChangePasswordVisibilityState extends WorkableLoginStates {}
