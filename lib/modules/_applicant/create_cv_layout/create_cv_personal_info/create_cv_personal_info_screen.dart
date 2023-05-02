import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/shared/caching/cache_helper.dart';
import 'package:gp2023/shared/components/components.dart';
import 'package:gp2023/shared/constants/constants.dart';
import 'package:intl/intl.dart';

import '../../../../main.dart';
import '../create_cv_Education/create_cv_education_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class CreateCVPersonalInfoScreen extends StatelessWidget {
  const CreateCVPersonalInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateCVPersonalInfoCubit, CreateCVPersonalInfoStates>(
        listener: (context, state) {
      if (state is CreateCVPersonalInfoErrorState) {
        showToast(
          text: state.error,
          state: ToastStates.ERROR,
        );
      }
      if (state is CreateCVPersonalInfoSuccessState &&
          IS_APPLICANT &&
          (CacheHelper.getData(key: 'email') != null || CacheHelper.getData(key: 'name') != null)) {
        CacheHelper.saveData(
          key: 'uId',
          value: state.uId,
        ).then((value) {});
      }
    }, builder: (context, state) {
      var cubit = CreateCVPersonalInfoCubit.get(context);

      final List<DropdownMenuItem<String>> citiesDropDownMenuItems = citiesList
          .map(
            (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
              ),
            ),
          )
          .toList();

      final List<DropdownMenuItem<String>> nationalityDropDownMenuItems2 = nationalityList
          .map(
            (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ),
          )
          .toList();

      final List<DropdownMenuItem<String>> jopTitleDropDownMenuItems2 =
          jopTitlesList.map((String value) {
        if (value.toLowerCase() == 'it' ||
            value.toLowerCase() == 'finance' ||
            value.toLowerCase() == 'medicine' ||
            value.toLowerCase() == 'other') {
          return DropdownMenuItem<String>(
              value: value,
              enabled: false,
              child: Text(
                value,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ));
        } else {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }
      }).toList();

      final List<DropdownMenuItem<String>> genderDropDownMenuItems2 = genderList
          .map(
            (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ),
          )
          .toList();

      String selectedDOB = '';

      // final List<DropdownMenuItem<String>> gradeDropDownMenuItems2 = gradesList
      //     .map(
      //       (String value) => DropdownMenuItem<String>(
      //         value: value,
      //         child: Text(value),
      //       ),
      //     )
      //     .toList();

      // final List<DropdownMenuItem<String>> countryDropDownMenuItems2 =
      //     countriesList
      //         .map(
      //           (String value) => DropdownMenuItem<String>(
      //             value: value,
      //             child: Text(value),
      //           ),
      //         )
      //         .toList();

      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'My CV',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          backgroundColor: const Color(0xff1B75BC),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: cubit.formKey,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  'Personal Details',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.grey,
                      ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                // Name
                dropDownListTitle('Name'),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: defaultFormField(
                    controller: cubit.nameController,
                    type: TextInputType.name,
                    label: 'Name',
                    suffix: Icons.person,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                // Email

                dropDownListTitle('Email'),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: defaultFormField(
                      controller: cubit.emailController,
                      type: TextInputType.emailAddress,
                      label: 'Email',
                      suffix: Icons.email,
                      prefix: null),
                ),
                const SizedBox(
                  height: 10,
                ),

                // Phone

                dropDownListTitle('Phone'),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: defaultFormField(
                      controller: cubit.phoneController,
                      type: TextInputType.phone,
                      label: 'Phone',
                      suffix: Icons.phone,
                      prefix: null,
                      validate: (String value) {
                        var phoneRegix = RegExp(r"^(010|011|012)\d{8}$");
                        if (value.isEmpty) {
                          return 'please enter your phone';
                        }
                        if (!phoneRegix.hasMatch(value)) {
                          return 'please enter a valid phone';
                        }
                      }),
                ),
                const SizedBox(
                  height: 10,
                ),

                // Gender

                dropDownListTitle('Gender'),
                const SizedBox(
                  height: 10,
                ),
                defaultDropDownList(
                    value: cubit.genderValue,
                    onChange: (value) => cubit.changeGenderState(value),
                    items: genderDropDownMenuItems2),
                const SizedBox(
                  height: 10,
                ),

                // Jop Title

                dropDownListTitle('Jop Title'),
                const SizedBox(
                  height: 10,
                ),
                defaultDropDownList(
                    value: cubit.jopTitleValue2,
                    onChange: (value) => cubit.changeJopTitleState(value),
                    items: jopTitleDropDownMenuItems2),
                const SizedBox(
                  height: 10,
                ),

                // Grade

                // dropDownListTitle('Grade'),
                // const SizedBox(
                //   height: 10,
                // ),
                // defaultDropDownList(
                //    value:  cubit.gradeValue,
                //     onChange: (value) => cubit.changeGradeState(value),
                //     items: gradeDropDownMenuItems2),
                // const SizedBox(
                //   height: 10,
                // ),

                // Country

                // dropDownListTitle('Country'),
                // const SizedBox(
                //   height: 10,
                // ),
                // defaultDropDownList(
                //
                //   value: cubit.countriesValue,
                //   onChange: (value) => cubit.changeCountryState(value),
                //   items: countryDropDownMenuItems2,
                // ),
                // const SizedBox(
                //   height: 10,
                // ),

                // City

                dropDownListTitle('City'),
                const SizedBox(
                  height: 10,
                ),
                defaultDropDownList(
                    value: cubit.cityValue,
                    onChange: (value) => cubit.changeCityState(value),
                    items: citiesDropDownMenuItems),
                const SizedBox(
                  height: 10,
                ),

                // Nationality

                dropDownListTitle('Nationality'),
                const SizedBox(
                  height: 10,
                ),
                defaultDropDownList(
                    value: cubit.nationalitiesValue,
                    onChange: (value) => cubit.changeNationalityState(value),
                    items: nationalityDropDownMenuItems2),
                const SizedBox(
                  height: 15,
                ),

                // Date of birth

                dropDownListTitle('Date of birth'),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    child: defaultDatePicker(cubit.dateTimeController, context, (value) {
                  cubit.dateTimeController.text = DateFormat.yMMMd().format(value).toString();
                }, 'Date of birth')),
                const SizedBox(
                  height: 30,
                ),

                // Button

                Center(
                  child: defaultButton(
                    function: () {
                      if (cubit.formKey.currentState!.validate()) {
                        if (IS_NEW_USER) {
                          cubit.cvCreate(
                              jobTitle: cubit.jopTitleValue2,
                              degree: cubit.gradeValue,
                              city: cubit.cityValue,
                              nationality: cubit.nationalitiesValue,
                              dateOfBirth: cubit.dateTimeController.text,
                              uId: CacheHelper.getData(key: 'uId'),
                              name: cubit.nameController.text.toString(),
                              phone: cubit.phoneController.text.toString(),
                              email: cubit.emailController.text.toString(),
                              gender: cubit.genderValue.toString());
                        }
                        navigateTo(context, CreateCvEducationScreen());
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
      );
    });
  }
}
