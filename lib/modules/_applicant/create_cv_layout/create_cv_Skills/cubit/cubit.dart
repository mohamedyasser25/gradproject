import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/modules/_applicant/create_cv_layout/create_cv_Skills/cubit/states.dart';
import 'package:gp2023/shared/components/components.dart';

import '../../../../../shared/caching/cache_helper.dart';
import '../../../../../shared/models/SkillsModel.dart';
import '../../../../../shared/models/jopTitleModel.dart';
import '../../../applicant_main_layout/layout/applicant_layout.dart';

class CreateCVSkillsCubit extends Cubit<CreateCVSkillsStates> {
  CreateCVSkillsCubit() : super(CreateCVSkillsInitialState());

  static CreateCVSkillsCubit get(context) => BlocProvider.of(context);

  var formKey = GlobalKey<FormState>();

  void skillsCreate(context,{required String uId}) {
    if (selectedSkills != []) {
      for (var element in selectedSkills) {
        SkillModel model = SkillModel(skillName: element.name, uId: uId);
        saveSkillData(model,context);
      }
    }
  }

  void saveSkillData(SkillModel M,context) {
    FirebaseFirestore.instance
        .collection('ApplicantSkills')
        .add(M.toMap())
        .then((value) {
      List list = CacheHelper.getData(key: 'SkillModel') ?? [];
      list.add(M.toMap());
      CacheHelper.saveData(key: 'SkillModel', value: list);
      emit(CreateCVSkillsSuccessState(M.uId));
      navigateTo(context, const ApplicantLayout());
      showToast(text: 'Loading...', state: ToastStates.SUCCESS);
    }).catchError((error) {
      emit(CreateCVSkillsErrorState(error.toString()));
    });
  }

  List<SkillsDataModel> selectedSkills = [];
  List<SkillsDataModel> SkillsItems = [
    SkillsDataModel(id: 1, name: 'flutter'),
    SkillsDataModel(id: 1, name: 'Java'),
    SkillsDataModel(id: 1, name: 'PHP'),
    SkillsDataModel(id: 1, name: 'Angular'),
    SkillsDataModel(id: 1, name: 'HTML'),
  ];

  void selectSkill(val, context) {
    selectedSkills = val;
    emit(ApplicantSelectSkillsState());
  }
}
