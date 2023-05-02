import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/modules/_applicant/create_cv_layout/create_cv_personal_info/cubit/states.dart';
import 'package:gp2023/shared/constants/constants.dart';
import 'package:gp2023/shared/caching/cache_helper.dart';

import '../../../../../shared/models/CVModel.dart';


class CreateCVPersonalInfoCubit extends Cubit<CreateCVPersonalInfoStates> {
  var formKey = GlobalKey<FormState>();
  var dateTime = DateTime.now();
  var dateTimeController = TextEditingController();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var genderController = TextEditingController();

  var cityValue = defaultDropDownListValue;
  var countriesValue = defaultDropDownListValue;
  var nationalitiesValue = defaultDropDownListValue;
  var jopTitleValue = defaultDropDownListValue;
  var jopTitleValue2 = defaultDropDownListValue;
  var genderValue = defaultDropDownListValue;
  var gradeValue = defaultDropDownListValue;

  CreateCVPersonalInfoCubit() : super(CreateCVPersonalInfoInitialState());

  static CreateCVPersonalInfoCubit get(context) => BlocProvider.of(context);

  void cvCreate(
      {required String name,
      required String phone,
      required String email,
      required String gender,
      required String jobTitle,
      required String degree,
      required String city,
      required String nationality,
      required String dateOfBirth,
      required String uId}) {

    CVModel model = CVModel(
        city: city,
        name: name,
        phone: phone,
        email: email,
        degree: degree,
        gender: gender,
        nationality: nationality,
        dateOfBirth: dateOfBirth,
        jobTitle: jobTitle,
        uId: uId);
    saveCVData(model);
  }

  final List<CVModel> cvDataList = [];

  void setRegisterData() async {
    nameController.text = CacheHelper.getData(key: "name");
    phoneController.text = CacheHelper.getData(key: "phone");
    emailController.text = CacheHelper.getData(key: "email");
    bool isMale = CacheHelper.getData(key: 'isMale') ?? true;
    String gender = isMale ? "Male" : "Female";
    genderValue = gender;

    await FirebaseFirestore.instance.collection('cv').get().then(((value) {
      for (var element in value.docs) {
        if (element.data()['uId'] == uId) {
          CVModel model;
          model = CVModel.fromJson(element.data());
          cvDataList.add(model);
        }
      }
      jopTitleValue2 = cvDataList[0].jobTitle.toString() ?? '';
      cityValue = cvDataList[0].city.toString() ?? '';
      nationalitiesValue = cvDataList[0].nationality.toString() ?? '';
      dateTimeController.text = cvDataList[0].dateOfBirth.toString() ?? '';
      emit(CreateCVPersonalInfoGetCvDataState());

    }));
  }

  void saveCVData(CVModel M) {
    FirebaseFirestore.instance.collection('cv').add(M.toMap()).then((value) {
      emit(CreateCVPersonalInfoSuccessState(M.uId));
    }).catchError((error) {
      emit(CreateCVPersonalInfoErrorState(error.toString()));
    });
  }

  void changeCityState(String cityOut) {
    cityValue = cityOut;
    emit(CreateCVPersonalInfoChangeCityState());
  }

  void changeCountryState(String countryValue) {
    countriesValue = countryValue;
    emit(CreateCVPersonalInfoChangeCountryState());
  }

  void changeNationalityState(String nationalityValue) {
    nationalitiesValue = nationalityValue;
    emit(CreateCVPersonalInfoChangeNationalityState());
  }

  void changeJopTitleState(String JopTitleValue) {
    jopTitleValue2 = JopTitleValue;
    emit(CreateCVPersonalInfoChangeJopTitleState());
  }

  void changeGenderState(String GenderValue) {
    genderValue = GenderValue;
    emit(CreateCVPersonalInfoChangeGenderState());
  }

  void changeGradeState(String GradeValue) {
    gradeValue = GradeValue;
    emit(CreateCVPersonalInfoChangeGradeState());
  }
}
