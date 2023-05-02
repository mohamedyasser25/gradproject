import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/modules/_common/filter/cubit/states.dart';
import 'package:intl/intl.dart';

import '../../../_applicant/applicant_main_layout/pages/applicant_home/cubit/cubit.dart';

class FilterCubit extends Cubit<FilterStates> {
  FilterCubit() : super(FilterInitialState());

  static FilterCubit get(context) => BlocProvider.of(context);

  var city = "Cairo";
  var country = "Egypt";
  var nationality = "Egyptian";
  var jopTitle = "front end web Developer";
  var grade = "Excellence";

  var formKey = GlobalKey<FormState>();
  TextEditingController fromDateTimeController = TextEditingController();
  TextEditingController toDateTimeController = TextEditingController();
  var salaryExpectationsController = TextEditingController();
  var salaryFromController = TextEditingController();
  var salaryToController = TextEditingController();

  void filter(context) async {
    ApplicantRegisterCubit.get(context).changeListFromFilter(
      context,
        jobTitle: jopTitle,
        country: country,
        city: city,
        fromDate: fromDateTimeController.text,
        toDate: fromDateTimeController.text,
        jobType: jopType,
        salary: double.parse(salaryExpectationsController.text),
        );

    Navigator.pop(context);
  }

  void restFilter(context) {
    city = "Cairo";
    country = "Egypt";
    nationality = "Egyptian";
    jopTitle = "front end web Developer";
    grade = "Excellence";

    formKey = GlobalKey<FormState>();
    fromDateTimeController.text = fromDateTimeController.text =
        DateFormat.yMMMd().format(DateTime.now()).toString();
    toDateTimeController.text = toDateTimeController.text =
        DateFormat.yMMMd().format(DateTime.now()).toString();
    salaryExpectationsController = TextEditingController();
    salaryFromController = TextEditingController();
    salaryToController = TextEditingController();
    ApplicantRegisterCubit.get(context).restListFromFilter();

    Navigator.pop(context);
  }

  void changeJopTitleState(String JopTitle) {
    jopTitle = JopTitle;
    emit(FilterApply());
  }

  void changeCityTitleState(String City) {
    city = City;
    emit(FilterApply());
  }

  void changeCountryTitleState(String Country) {
    print(country);
    country = Country;
    emit(FilterApply2());
  }

  String jopType = "";
  double? salaryFrom;
  double? salaryTo;

  void filterApply(BuildContext context,
      {double? salaryfrom, double? salaryto, String? companyName}) {
    salaryFrom = salaryfrom;
    salaryTo = salaryto;
    ApplicantRegisterCubit.get(context).searchList = [];
    emit(FilterApply());
  }
}
