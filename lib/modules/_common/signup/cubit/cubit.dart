import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/modules/_common/signup/cubit/states.dart';
import 'package:gp2023/shared/caching/cache_helper.dart';

import '../../../../main.dart';
import '../../../../shared/models/user_model.dart';
//import 'package:gp2023/shared/network/end_points.dart';

class WorkableRegisterCubit extends Cubit<WorkableRegisterStates> {
  WorkableRegisterCubit() : super(WorkableRegisterInitialState());

  static WorkableRegisterCubit get(context) => BlocProvider.of(context);

  bool isMale = true;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(WorkableRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
          uId: value.user!.uid,
          phone: phone,
          email: email,
          name: name,
          isMale: isMale,
          password: password,
          isApplicant: IS_APPLICANT);
    });
        // .catchError((error) {
      // print('===============================');
      // print(error.toString());
      // print('===============================');
      // emit(WorkableRegisterErrorState(error.toString()));
    // });
  }

  void userCreate(
      {required String name,
      required String email,
      required String phone,
      required String uId,
      required bool isMale,
      required String password,
      required bool isApplicant}) {
    WorkableUserModel model = WorkableUserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        isMale: isMale,
        isEmailVerified: false,
        password: password,
        isApplicant: isApplicant);
    CacheHelper.saveData(key: 'uId', value: uId);
    CacheHelper.saveData(key: 'name', value: name);
    CacheHelper.saveData(key: 'phone', value: phone);
    CacheHelper.saveData(key: 'email', value: email);
    CacheHelper.saveData(key: 'isMale', value: isMale);
    CacheHelper.saveData(key: 'isApplicant', value: isApplicant);

    FirebaseFirestore.instance
        .collection('Applicant')
        .doc(uId)
        .set(model.toMap())
        .then((value) {

      FirebaseFirestore.instance
          .collection('company')
          .doc(CacheHelper.getData(key: 'companyId'))
          .update({'hrID': uId})
          .then((value) {
        print('zzzzz hi companyId ${CacheHelper.getData(key: 'companyId')}');
        print('zzzzz hi uid $uId');
      });

      print('xxxxx hi x');
      emit(WorkableCreateUserSuccessState());
      }).catchError((error) {
      print(error.toString());
      emit(WorkableCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(WorkableRegisterChangePasswordVisibilityState());
  }

  void changeUserGenderIsMale(String isMaleOut) {
    isMale = isMaleOut == 'Male' ? true : false;
    emit(WorkableChangeGenderIsMaleState());
  }
}
