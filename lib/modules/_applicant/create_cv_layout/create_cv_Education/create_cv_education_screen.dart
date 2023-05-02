import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gp2023/shared/components/components.dart';
import 'package:gp2023/shared/constants/constants.dart';
import 'package:gp2023/shared/caching/cache_helper.dart';

import 'package:intl/intl.dart';

import '../../../../main.dart';
import '../create_cv_Experience/create_cv_experience_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class CreateCvEducationScreen extends StatelessWidget {
  CreateCvEducationScreen({Key? key}) : super(key: key);

  late DateTime startDate;
  late DateTime endDate;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateCVEducationCubit,
        CreateCvEducationStates>(listener: (context, state) {
      if (state is CreateCvEducationErrorState) {
        showToast(
          text: state.error,
          state: ToastStates.ERROR,
        );
      }
      if (state is CreateCvEducationSuccessState &&
          IS_APPLICANT &&
          (CacheHelper.getData(key: 'email') != null ||
              CacheHelper.getData(key: 'name') != null)) {
        CacheHelper.saveData(
          key: 'uId',
          value: state.uId,
        ).then((value) {});
      }
    }, builder: (context, state) {
      var cubit = CreateCVEducationCubit.get(context);

      final List<DropdownMenuItem<String>> dropDownMenuItems2 = uniList
          .map(
            (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ),
          )
          .toList();

      final List<DropdownMenuItem<String>> educationLevelDropDownMenuItems2 =
          educationLevelsList
              .map(
                (String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ),
              )
              .toList();

      final List<DropdownMenuItem<String>> facultiesDropDownMenuItems2 =
          facultiesList
              .map(
                (String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ),
              )
              .toList();

      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Education',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          backgroundColor: const Color(0xff1B75BC),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: cubit.formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add your education data',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),

                      //Education Level
                      dropDownListTitle('Education Level'),
                      const SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        child: defaultDropDownList(
                            value: cubit.educationLevelsValue,
                            onChange: (value) {
                          if (value != null) {
                            cubit.changeEducationLevelState(value);
                          }
                        },
                            items: educationLevelDropDownMenuItems2),
                      ),

                      //Faculty
                      const SizedBox(
                        height: 15.0,
                      ),
                      dropDownListTitle('Faculty'),
                      const SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        child:
                            defaultDropDownList(
                                value: cubit.facultiesValue,
                                    onChange: (value) {
                          if (value != null) {
                            cubit.changeFacultyState(value);
                          }
                        }, items: facultiesDropDownMenuItems2),
                      ),

                      //University

                      const SizedBox(
                        height: 15,
                      ),
                      dropDownListTitle('University'),
                      const SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        child:
                            defaultDropDownList(value: cubit.universityValue,onChange:  (value) {
                          if (value != null) {
                            cubit.changeNationalityState(value);
                          }
                        }, items: dropDownMenuItems2),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),

                      //First date
                      SizedBox(
                          child: defaultDatePicker(
                              cubit.startDateTimeController, context, (value) {
                            startDate = value;
                        cubit.startDateTimeController.text =
                            DateFormat.yMMMd().format(value).toString();
                      }, "start date")),
                      const SizedBox(
                        height: 15,
                      ),
                      //End date
                      SizedBox(
                          child: defaultDatePicker(
                              cubit.endDateTimeController, context, (value) {
                            endDate = value;
                        cubit.endDateTimeController.text =
                            DateFormat.yMMMd().format(value).toString();
                      }, "end date")),

                      const SizedBox(
                        height: 30.0,
                      ),
                      Center(
                        child: defaultButton(
                          function: () {
                            if (cubit.formKey.currentState!.validate()) {
                              cubit.educationCreate(
                                  educationLevel:
                                      cubit.educationLevelsValue,
                                  faculty: cubit.facultiesValue,
                                  university:
                                      CreateCVEducationCubit.get(context)
                                          .universityValue,
                                  endDate: cubit.endDateTimeController.text,
                                  startDate: cubit.startDateTimeController.text,
                                  uId: CacheHelper.getData(key: 'uId'));

                              cubit.educationLevelsValue =defaultDropDownListValue;

                              cubit.facultiesValue = defaultDropDownListValue;
                              cubit.startDateTimeController =
                                  TextEditingController();
                              cubit.endDateTimeController =
                                  TextEditingController();
                            }

                          },
                          text: 'Save and Add Another Education',
                          isUpperCase: true,
                          background: const Color(0xff1B75BC),
                          radius: 50,
                          width: 300,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      Center(
                        child: defaultButton(
                          function: () {
                            if (cubit.formKey.currentState!.validate()) {
                              if(IS_NEW_USER) {
                                if(startDate.isAfter(endDate)) {
                                  showToast(text: 'Not valid start/end date', state: ToastStates.ERROR);
                                } else {
                                  cubit.educationCreate(
                                      educationLevel:
                                      CreateCVEducationCubit.get(context)
                                          .educationLevelsValue,
                                      faculty:
                                      CreateCVEducationCubit.get(context)
                                          .facultiesValue,
                                      university:
                                      CreateCVEducationCubit.get(context)
                                          .universityValue,
                                      endDate: cubit.endDateTimeController.text,
                                      startDate: cubit.startDateTimeController.text,
                                      uId: CacheHelper.getData(key: 'uId'));
                                  navigateTo(context, const CreateCVExperienceScreen());
                                }
                              }
                            }
                          },
                          text: 'next',
                          background: const Color(0xff1B75BC),
                          radius: 50,
                          width: 200,
                          isUpperCase: true,
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      );
    });
  }
}
