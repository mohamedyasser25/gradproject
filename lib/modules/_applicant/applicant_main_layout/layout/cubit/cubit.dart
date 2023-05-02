import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/modules/_applicant/applicant_main_layout/layout/cubit/states.dart';

import '../../pages/applicant_Saved_apps/applicant_Saved_apps_page.dart';
import '../../pages/applicant_apps_status/applicant_apps_status_page.dart';
import '../../pages/applicant_home/applicant_home_page.dart';

class ApplicantCubit extends Cubit<ApplicantStates> {
  ApplicantCubit() : super(ApplicantInitialState());

  static ApplicantCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  void getApplicantString() {
    emit(ApplicantUserStringState());
  }

  List<Widget> screens = [
    const ApplicantHomePage(),
    ApplicantAppsStatusPage(),
    const ApplicantSavedAppsPage(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(ApplicantChangeBottomNavBarState());
  }
}
