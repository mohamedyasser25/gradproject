abstract class CreateCvEducationStates {}

class CreateCvEducationInitialState
    extends CreateCvEducationStates {}

class CreateCvEducationSuccessState
    extends CreateCvEducationStates {
  final String uId;

  CreateCvEducationSuccessState(this.uId);
}

class CreateCvEducationErrorState
    extends CreateCvEducationStates {
  final String error;

  CreateCvEducationErrorState(this.error);
}

class CreateCvEducationChangeCityState
    extends CreateCvEducationStates {}

class CreateCvEducationChangeNationalityState
    extends CreateCvEducationStates {}
class CreateCvEducationChangeeducationLevelState
    extends CreateCvEducationStates {}



class CreateCvEducationChangeFacultyState
    extends CreateCvEducationStates {}

class ApplicantPrimativeDataChangeEducationLevelState extends CreateCvEducationStates {}
