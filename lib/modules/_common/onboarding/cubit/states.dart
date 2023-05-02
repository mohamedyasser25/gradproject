abstract class WorkableStates {}

class WorkableInitialState extends WorkableStates {}

class WorkableGetUserLoadingState extends WorkableStates {}

class WorkableGetUserSuccessState extends WorkableStates {}

class WorkableUpdateIsEmailVerified extends WorkableStates {}

class WorkableGetUserErrorState extends WorkableStates {
  final String error;

  WorkableGetUserErrorState(this.error);
}
