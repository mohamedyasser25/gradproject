abstract class CreateCVExperienceStates {}

class CreateCVExperienceInitialState
    extends CreateCVExperienceStates {}

class CreateCVExperienceSuccessState
    extends CreateCVExperienceStates {
  final String uId;

  CreateCVExperienceSuccessState(this.uId);
}

class CreateCVExperienceErrorState
    extends CreateCVExperienceStates {
  final String error;

  CreateCVExperienceErrorState(this.error);
}

class CreateCVExperienceChangeCityState
    extends CreateCVExperienceStates {}

class CreateCVExperienceChangePositionState
    extends CreateCVExperienceStates {}
