import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gp2023/shared/constants/constants.dart';
import 'package:intl/intl.dart';

import '../../../../main.dart';
import '../../../../shared/caching/cache_helper.dart';
import '../../../../shared/components/components.dart';
import '../create_cv_Skills/create_cv_skills.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class CreateCVExperienceScreen extends StatelessWidget {
  const CreateCVExperienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateCVExperienceCubit,
        CreateCVExperienceStates>(listener: (context, state) {
      if (state is CreateCVExperienceErrorState) {
        showToast(
          text: state.error,
          state: ToastStates.ERROR,
        );
      }
      if (state is CreateCVExperienceSuccessState &&
          IS_APPLICANT &&
          (CacheHelper.getData(key: 'email') != null ||
              CacheHelper.getData(key: 'name') != null)) {
        CacheHelper.saveData(
          key: 'uId',
          value: state.uId,
        ).then((value) {});
      }
    }, builder: (context, state) {
      var cubit = CreateCVExperienceCubit.get(context);
      final List<DropdownMenuItem<String>> positionDropDownMenuItems2 =
          positionsList
              .map(
                (String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ),
              )
              .toList();

      late DateTime startDate;
      late DateTime endDate;

      return Scaffold(
        appBar: AppBar(
          title: const Text(
            ' Experience',
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
                        'Add your Experience data',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),

                      //Company Name

                      const SizedBox(
                        height: 15.0,
                      ),
                      dropDownListTitle('Company Name'),
                      const SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        child: defaultFormField(
                          controller: cubit.companyNameController,
                          type: TextInputType.text,
                          label: 'Company Name',
                          prefix: Icons.school,
                        ),
                      ),

                      //Position
                      const SizedBox(
                        height: 15.0,
                      ),
                      const Text('Position',
                          style: TextStyle(
                              fontSize: 15,
                              color: Color(0xff1B75BC),
                              fontWeight: FontWeight.w700)),
                      const SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        child:
                            defaultDropDownList(value: cubit.positionsValue, onChange: (value) {
                          if (value != null) {
                            cubit.changePositionState(value);
                          }
                        }, items: positionDropDownMenuItems2),
                      ),

                      //start date

                      const SizedBox(
                        height: 15,
                      ),
                      dropDownListTitle('Start date'),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                          child: defaultDatePicker(
                              cubit.startDateTimeController, context, (value) {
                            startDate = value;
                        cubit.startDateTimeController.text =
                            DateFormat.yMMMd().format(value).toString();
                      }, "Start date")),

                      //End date
                      const SizedBox(
                        height: 15,
                      ),
                      dropDownListTitle('End date'),
                      const SizedBox(
                        height: 15,
                      ),

                      SizedBox(
                          child: defaultDatePicker(
                              cubit.endDateTimeController, context, (value) {
                            endDate = value;
                            cubit.endDateTimeController.text =
                            DateFormat.yMMMd().format(value).toString();
                      }, "End date")),

                      const SizedBox(
                        height: 30.0,
                      ),
                      Center(
                        child: defaultButton(
                          function: () {
                            if (cubit.formKey.currentState!.validate()) {
                              if (startDate.isAfter(endDate)) {
                                showToast(text: 'Not valid start/end date', state: ToastStates.ERROR);
                              } else {
                                if(IS_NEW_USER) {
                                  cubit.experienceCreate(
                                      companyName: cubit.companyNameController.text,
                                      position: CreateCVExperienceCubit.get(
                                          context)
                                          .positionsValue,
                                      endDate: cubit.endDateTimeController.text,
                                      startDate: cubit.startDateTimeController.text,
                                      uId: CacheHelper.getData(key: 'uId'));
                                }

                                cubit.startDateTimeController =
                                    TextEditingController();
                                cubit.endDateTimeController =
                                    TextEditingController();
                                cubit.companyNameController =
                                    TextEditingController();
                                cubit.positionsValue = defaultDropDownListValue;
                              }
                            }
                          },
                          text: 'Save and Add Another Experience',
                          background: const Color(0xff1B75BC),
                          radius: 50,
                          width: 300,
                          isUpperCase: true,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: defaultButton(
                          function: () {
                            if (cubit.formKey.currentState!.validate()) {
                              if (startDate.isAfter(endDate)) {
                                showToast(text: 'Not valid start/end date', state: ToastStates.ERROR);
                              } else {
                                cubit.experienceCreate(
                                    companyName: cubit.companyNameController.text,
                                    position: CreateCVExperienceCubit.get(
                                        context)
                                        .positionsValue,
                                    endDate: cubit.endDateTimeController.text,
                                    startDate: cubit.startDateTimeController.text,
                                    uId: CacheHelper.getData(key: 'uId'));
                                navigateTo(
                                    context, const CreateCVSkillsScreen());
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
