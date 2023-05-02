import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../main.dart';
import '../../../../shared/caching/cache_helper.dart';
import 'states.dart';

class WorkableLoginCubit extends Cubit<WorkableLoginStates> {
  WorkableLoginCubit() : super(WorkableLoginInitialState());

  static WorkableLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(WorkableLoginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value1) {
      FirebaseFirestore.instance
          .collection('Applicant')
          .doc(value1.user!.uid)
          .get()
          .then((value2) {
        IS_APPLICANT = value2.data()!['isApplicant'];
        CacheHelper.saveData(key: 'isApplicant', value: IS_APPLICANT);
        CacheHelper.saveData(key: 'name', value: value2.data()!['name']);
        CacheHelper.saveData(key: 'email', value: value2.data()!['email']);
        if (!IS_APPLICANT) {
          FirebaseFirestore.instance
              .collection('company')
              .where('hrID', isEqualTo: value1.user!.uid)
              .get()
              .then((value3) {
            if (value3.docs.isNotEmpty) {
              CacheHelper.saveData(
                  key: 'companyName', value: value3.docs.first.data()['name']);
            } else {
              CacheHelper.saveData(key: 'companyName', value: "NONE");
            }
            emit(WorkableLoginSuccessState(value1.user!.uid));
          });
        } else {
          emit(WorkableLoginSuccessState(value1.user!.uid));
        }
      }).catchError((error) {
        print(error.toString());
        emit(WorkableLoginErrorState(error.toString()));
      });
      emit(WorkableLoginSuccessState(value1.user!.uid));
    }).catchError((error) {
      emit(WorkableLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(WorkableChangePasswordVisibilityState());
  }
}
