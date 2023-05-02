import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/modules/_hr/hr_home/cubit/states.dart';
import 'package:gp2023/shared/caching/cache_helper.dart';
import 'package:gp2023/shared/components/components.dart';
import 'package:gp2023/shared/constants/constants.dart';

import '../../../../shared/models/job_model.dart';

class HrCubit extends Cubit<HrStates> {
  HrCubit() : super(HrInitialState());

  static HrCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  //HrUserModel model;
  void getHrString() {
    emit(HrUserStringState());
  }

  bool isBottomSheetShown = false;
  var jobTypeValue = defaultDropDownListValue;
  var qualificationsValue = defaultDropDownListValue;
  var experienceValue = defaultDropDownListValue;
  var jobTitleValue = defaultDropDownListValue;
  var skillsList = [];
  var positionValue = defaultDropDownListValue;
  var itemsList = [];

  void changePositions(String poisitons) {
    positionValue = poisitons;
    emit(HrChangePositonsValueState());
  }

  IconData fabIcon = Icons.add;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  void changeIndex(int index) {
    currentIndex = index;
    emit(HrChangeBottomNavBarState());
  }

  void changeJobType(String jobType) {
    jobTypeValue = jobType;
    emit(HrChangeJobTypeState());
  }

  void changeJobTitle(String jobTitle) {
    jobTitleValue = jobTitle;
    emit(HrChangeJobTitleState());
  }

  void changeExperience(String experience) {
    experienceValue = experience;
    emit(HrChangeExperienceValueState());
  }

  Future<String> getCompanyId(String uId) async {
    final companySnapshot =
        await FirebaseFirestore.instance.collection('company').where('hrID', isEqualTo: uId).get();

    if (companySnapshot.docs.isNotEmpty) {
      final companyId = companySnapshot.docs.first.id;
      return companyId;
    } else {
      throw Exception('No company found for HR with ID $uId');
    }
  }

  void createJob(
      {required String jobTitle,
      required String jobDescription,
      required num salary,
      required DateTime endDate,
      required String jobTypeValue,
      required String positionValue,
      required String experienceValue,
      required List<String> skillsList,
      required List<String> requirementList}) {
    JobModel jobModel = JobModel(
        jobTitle: jobTitle,
        jobDescription: jobDescription,
        salary: salary,
        startDate: DateTime.now(),
        endDate: endDate,
        jobType: jobTypeValue,
        position: positionValue,
        experienceYears: experienceValue,
        jobSkills: skillsList,
        jobRequirement: requirementList);
    print(jobModel);

    var uId = CacheHelper.getData(key: 'uId');
    FirebaseFirestore.instance
        .collection('company')
        .where("hrID", isEqualTo: uId)
        .get()
        .then((querySnapshot) {
      print('zzzzz $uId');
      var id = querySnapshot.docs.first.id;
      print('zzzzz 2 $id');
      jobModel.companyId = id;
      FirebaseFirestore.instance.collection('jobs').add(jobModel.toJson()).then((value) {
        showToast(text: 'saved successfully', state: ToastStates.SUCCESS);

        emit(HrSaveSuccessState());
      }).catchError((error) {
        emit(HrGetUserErrorState(error.toString()));
        print('zzzzz oopps 2');
      });
    }).catchError((error) {
      print(error.toString());
      print('zzzzz oopps');
    });
  }

  getCompanyJobPosts() {
    FirebaseFirestore.instance
        .collection('company')
        .where("hrID", isEqualTo: uId)
        .get()
        .then((querySnapshot) {
      print('zzzzz $uId');
      var id = querySnapshot.docs.first.id;

      FirebaseFirestore.instance
          .collection('jobs')
          .where('companyID', isEqualTo: id)
          .get()
          .then((value) {
        print('zzzzzzz x ${CacheHelper.getData(key: 'companyId')}');
        List<JobModel> jobs = value.docs.map((e) {
          JobModel job = JobModel.fromJson(e.data());
          job.id = e.id;
          return job;
        }).toList();

        emit(HrGetJobsSuccessState(jobs));
      }).catchError((error) {
        print(error.toString());
        emit(HrGetJobsErrorState(error.toString()));
      });
    });
  }
}
