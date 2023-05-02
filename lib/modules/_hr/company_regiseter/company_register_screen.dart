import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/modules/_common/signup/signup_screen.dart';
import 'package:gp2023/shared/components/components.dart';

import '../../../main.dart';
import '../../../shared/caching/cache_helper.dart';
import '../../../shared/constants/constants.dart';
import '../../_common/login/login_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class CompanyRegisterScreen extends StatelessWidget {
  const CompanyRegisterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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

    final List<DropdownMenuItem<String>> countryDropDownMenuItems2 =
        countriesList
            .map(
              (String value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ),
            )
            .toList();

    return BlocConsumer<HrRegisterCubit, HrRegisterStates>(
      listener: (_, state) {
        if (state is HrRegisterSuccessState) {
          IS_APPLICANT = false;
        CacheHelper.saveData(key: 'isApplicant', value: false);
        navigateTo(
            context,
            SignupScreen(),
          );
        }
      },
      builder: (_, state) {
        var cubit = HrRegisterCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      logoIcon(),
                      const SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Text(
                          'Company Register',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: Colors.blue,
                              ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Add company details',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: Colors.black,
                              ),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defaultFormField(
                        controller: cubit.nameController,
                        type: TextInputType.name,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'please enter company name';
                          }
                        },
                        label: 'Company Name',
                        prefix: Icons.apartment,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: cubit.emailController,
                        type: TextInputType.emailAddress,
                        validate: (String value) {
                          var emailregex = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                          if (value.isEmpty) {
                            return 'please enter your email address';
                          }
                          if (!emailregex.hasMatch(value)) {
                            return 'please enter a valid email address';
                          }
                        },
                        label: 'Company Email Address',
                        prefix: Icons.email_outlined,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        child: defaultFormField(
                            controller: cubit.phoneController,
                            type: TextInputType.phone,
                            label: 'Phone',
                            validate: (String value) {
                              var phoneRegix =
                                  RegExp(r"^(010|011|012)\d{8}$");
                              if (value.isEmpty) {
                                return 'please enter your phone';
                              }
                              if (!phoneRegix.hasMatch(value)) {
                                return 'please enter a valid phone';
                              }
                            },
                            prefix: Icons.phone),
                      ),

                      const SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                        controller: cubit.companyCodeController,
                        type: TextInputType.number,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'please enter company code';
                          }
                        },
                        label: 'Company Tax Code',
                        prefix: Icons.receipt_long,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      dropDownListTitle('Country'),
                      const SizedBox(
                        height: 10,
                      ),
                      defaultDropDownList(
                          value: cubit.countriesValue,
                          onChange: (value) {
                            cubit.changeCountryState(value);
                          },
                          items: countryDropDownMenuItems2),
                      const SizedBox(
                        height: 10,
                      ),

                      // City

                      dropDownListTitle('City'),
                      const SizedBox(
                        height: 10,
                      ),
                      defaultDropDownList(
                          value: cubit.cityValue,
                          onChange: (value) {
                            cubit.changeCityState(value);
                          },
                          items: citiesDropDownMenuItems),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: cubit.descriptionController,
                        type: TextInputType.text,
                        maxLine: 12,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'description must not be empty';
                          }
                        },
                        label: 'Description',
                        prefix: Icons.line_style,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      state is! HrRegisterLoadingState ?  defaultButton(
                        function: () {
                          if (cubit.formKey.currentState!.validate()) {
                            HrRegisterCubit.get(context).companyCreate(
                              companyName: cubit.nameController.text,
                              companyEmail: cubit.emailController.text,
                              cityValue: cubit.cityValue,
                              countriesValue: cubit.countriesValue,
                              companyCode: int.parse(
                                  cubit.companyCodeController.text),
                              phone: cubit.phoneController.text,
                              description: cubit.descriptionController.text,
                            );
                          }
                        },
                        text: 'register',
                        isUpperCase: true,
                      ): const Center(child: CircularProgressIndicator()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already regitered?',
                          ),
                          defaultTextButton(
                            function: () {
                              navigateTo(
                                context,
                                LoginScreen(),
                              );
                            },
                            text: 'Log in',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
