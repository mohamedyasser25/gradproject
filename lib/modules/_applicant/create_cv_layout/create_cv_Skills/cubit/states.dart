abstract class CreateCVSkillsStates {}

class CreateCVSkillsInitialState extends CreateCVSkillsStates {}

class CreateCVSkillsSuccessState extends CreateCVSkillsStates {
  final String uId;

  CreateCVSkillsSuccessState(this.uId);
}

class CreateCVSkillsErrorState extends CreateCVSkillsStates {
  final String error;

  CreateCVSkillsErrorState(this.error);
}

class CreateCVSkillsChangeCityState
    extends CreateCVSkillsStates {}

class CreateCVSkillsChangeNationalityState
    extends CreateCVSkillsStates {}


class ApplicantSelectSkillsState
    extends CreateCVSkillsStates {}
