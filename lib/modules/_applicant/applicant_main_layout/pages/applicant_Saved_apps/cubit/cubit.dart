import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/modules/_applicant/applicant_main_layout/pages/applicant_Saved_apps/cubit/states.dart';

class ApplicantSavedRegisterCubit extends Cubit<ApplicantSavedRegisterStates> {
  ApplicantSavedRegisterCubit() : super(ApplicantSavedHomeInitialState());

  static ApplicantSavedRegisterCubit get(context) => BlocProvider.of(context);
}
