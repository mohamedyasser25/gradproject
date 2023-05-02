import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/modules/_applicant/create_cv_layout/create_cv_Education/cubit/states.dart';
import 'package:gp2023/shared/constants/constants.dart';

import '../../../../../shared/caching/cache_helper.dart';
import '../../../../../shared/models/EducationModel.dart';

class CreateCVEducationCubit
    extends Cubit<CreateCvEducationStates> {
  CreateCVEducationCubit()
      : super(CreateCvEducationInitialState());

  static CreateCVEducationCubit get(context) => BlocProvider.of(context);

  var formKey = GlobalKey<FormState>();


  var startDateTimeController = TextEditingController();
  var endDateTimeController = TextEditingController();

  var educationLevelsValue = defaultDropDownListValue;
  var facultiesValue = defaultDropDownListValue;
  var universityValue = defaultDropDownListValue;

  void educationCreate(
      {required String educationLevel,
      required String university,
      required String faculty,
      required String startDate,
      required String endDate,
      required String uId}) {
    EducationModel model = EducationModel(
        educationLevel: educationLevel,
        university: university,
        faculty: faculty,
        startDate: startDate,
        endDate: endDate,
        uId: uId);
    saveEducationData(model);
  }

  void saveEducationData(EducationModel M) {
    FirebaseFirestore.instance
        .collection('Education')
        .add(M.toMap())
        .then((value) {
      emit(CreateCvEducationSuccessState(M.uId));
    }).catchError((error) {
      emit(CreateCvEducationErrorState(error.toString()));
    });
  }

  void changeCityState(String cityOut) {
    universityValue = cityOut;
    emit(CreateCvEducationChangeCityState());
  }

  void changeNationalityState(String nationalityOut) {
    universityValue = nationalityOut;
    emit(CreateCvEducationChangeNationalityState());
  }

  void changeEducationLevelState(String educationLevelValue) {
    educationLevelsValue = educationLevelValue;
    emit(CreateCvEducationChangeeducationLevelState());
  }

  void changeFacultyState(String facultyValue) {
    facultiesValue = facultyValue;
    emit(CreateCvEducationChangeFacultyState());
  }
}
