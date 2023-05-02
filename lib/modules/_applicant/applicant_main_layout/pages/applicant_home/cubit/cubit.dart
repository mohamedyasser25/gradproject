import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/modules/_applicant/applicant_main_layout/pages/applicant_home/cubit/states.dart';

import '../../../../../../shared/models/job_model.dart';

class ApplicantRegisterCubit extends Cubit<ApplicantRegisterStates> {
  ApplicantRegisterCubit() : super(ApplicantHomeInitialState());
  // {
  //   // listofJobs = JobSearch().streamBuilder('', 'JobTitle');
  // //  listTempOfJobs = listMasterOfJobs;
  // }

  static ApplicantRegisterCubit get(context) => BlocProvider.of(context);

  void getApplicantRegisterString() {
    emit(ApplicantUserStringState());
  }

  List<String> d = [];
  getAllJobs() async {
    FirebaseFirestore.instance.collection('jobs').snapshots().listen((event) {
      // listOfJobsMaster =
      // event.docs.map((x) => job_model.fromJson(x.data()["id"])).toList();
      listOfJobsMaster = event.docs.map((x) {
        var data = x.data();
        data["id"] = x.id;
        return JobModel.fromJson(data);
      }).toList();

      listOfJobs = listOfJobsMaster;

      // listOfJobs.forEach((element) {
      //   d.add(element.JobType);
      // });

      print(d.toList().toSet().toList());
      emit(ApplicantHomeSearchState());
    });
  }

  void updateJobList(BuildContext context) {}

  int jobsCount = 0;
  List<JobModel> searchList = [];
  List<JobModel> listOfJobs = [];
  List<JobModel> listOfJobsMaster = [];
  //StreamBuilder<List<JobModel>> listofJobs;

  void changeListSearch(String search, BuildContext context) {
    if (search.isEmpty) {
      listOfJobs = listOfJobsMaster;
    } else {
      listOfJobs = listOfJobsMaster
          .where((element) => (element.jobDescription! +
                  element.jobTitle! +
                  element.salary.toString() +
                  element.jobType!)
              .toLowerCase()
              .contains(search.toLowerCase()))
          .toList();
      emit(ApplicantHomeSearchState());
    }
  }

  void changeListFromFilter(BuildContext context, {
      String? jobTitle,
      String? jobType,
      String? city,
      String? country,
      double? salary,
      String? fromDate,
      String? jopType,
      String? toDate,
  }) {

    DateTime now = DateTime.now();

    listOfJobs = listOfJobsMaster
        .where((element) =>
                element.jobTitle?.toLowerCase() == jobTitle?.toLowerCase() &&
                element.salary == salary &&
                jobType!.contains(element.jobType!)
            // &&
            // element.startDate.isAfter(startDate)
            // &&
            // element.endDate.isBefore(endDate)

            )
        .toList();

    emit(ApplicantHomeSearchState());
    // }
  }

  void restListFromFilter() {
    // if (search.isEmpty) {
    //   listOfJobs = listOfJobsMaster;
    // } else {
    listOfJobs = listOfJobsMaster.toList();
    emit(ApplicantHomeSearchState());
    // }
  }

  // void changeListSearch(String search, BuildContext context) {
  //   if (search.isEmpty) {
  //     listofJobs = JobSearch().streamBuilder('', 'JobTitle');
  //   } else {
  //     listofJobs = JobSearch().streamBuilder(search, 'JobTitle');
  //     emit(ApplicantHomeSearchState());
  //   }
  // }
}
