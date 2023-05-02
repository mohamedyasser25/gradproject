import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/modules/_common/onboarding/cubit/states.dart';
import 'package:gp2023/shared/caching/cache_helper.dart';

import '../../../../shared/models/user_model.dart';

class WorkableCubit extends Cubit<WorkableStates> {
  WorkableCubit() : super(WorkableInitialState());

  static WorkableCubit get(context) => BlocProvider.of(context);

  WorkableUserModel? model;

  void getUserData() {
    emit(WorkableGetUserLoadingState());

    FirebaseFirestore.instance
        .collection('Applicant')
        .doc(CacheHelper.getData(key: 'uId'))
        .get()
        .then((value) {
      model = WorkableUserModel.fromJson(value.data()!);
      emit(WorkableGetUserSuccessState());
    }).catchError((error) {
      //print(error.toString());
      emit(WorkableGetUserErrorState(error.toString()));
    });
  }

  void updateIsEmailVerified() {
    FirebaseFirestore.instance
        .collection('Applicant')
        .doc(CacheHelper.getData(key: 'uId'))
        .update({"isEmailVerified": true})
        .then((value) => emit(WorkableUpdateIsEmailVerified()))
        .catchError((error) {
          //print(error.toString());
          emit(WorkableGetUserErrorState(error.toString()));
        });
  }
}
