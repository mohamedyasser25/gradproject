abstract class CreateCVPersonalInfoStates {}

class CreateCVPersonalInfoInitialState extends CreateCVPersonalInfoStates {}

class CreateCVPersonalInfoSuccessState extends CreateCVPersonalInfoStates {
  final String uId;

  CreateCVPersonalInfoSuccessState(this.uId);
}

class CreateCVPersonalInfoErrorState extends CreateCVPersonalInfoStates {
  final String error;

  CreateCVPersonalInfoErrorState(this.error);
}

class CreateCVPersonalInfoChangeCityState
    extends CreateCVPersonalInfoStates {}


class CreateCVPersonalInfoChangeCountryState
    extends CreateCVPersonalInfoStates {}


class CreateCVPersonalInfoChangeEducationLevelState
    extends CreateCVPersonalInfoStates {}



class CreateCVPersonalInfoChangeNationalityState
    extends CreateCVPersonalInfoStates {}

class CreateCVPersonalInfoChangeJopTitleState extends CreateCVPersonalInfoStates {}

class CreateCVPersonalInfoChangeGradeState extends CreateCVPersonalInfoStates {}


class CreateCVPersonalInfoChangeGenderState extends CreateCVPersonalInfoStates {}


class CreateCVPersonalInfoSetRegisterDataState extends CreateCVPersonalInfoStates {}



class CreateCVPersonalInfoGetCvDataState
    extends CreateCVPersonalInfoStates {}
