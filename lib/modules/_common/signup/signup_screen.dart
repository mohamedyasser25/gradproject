import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/modules/_common/login/login_screen.dart';
import 'package:gp2023/modules/_hr/hr_home/hr_home_screen.dart';
import 'package:gp2023/shared/components/components.dart';

import '../../../main.dart';
import '../onboarding/onboarding_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SignupScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  static const genderList = <String>[
    'Male',
    'Female',
  ];
  static const applicantRoleList = <String>[
    'Applicant',
    'HR',
  ];
  final List<DropdownMenuItem<String>> _dropDownMenuItems = genderList
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  final List<DropdownMenuItem<String>> _rolesDropDownMenuItems = applicantRoleList
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkableRegisterCubit, WorkableRegisterStates>(
      listener: (_, state) {
        if (state is WorkableCreateUserSuccessState) {
          if (IS_APPLICANT == true) {
            navigateAndFinish(
              context,
              const OnBoardingScreen(),
            );
          } else {
            navigateAndFinish(
              context,
              const HrHomeScreen(),
            );
          }
        } else {}
      },
      builder: (_, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      logoIcon(),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'REGISTER',
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      Text(
                        'Register now to communicate with friends',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'please enter your name';
                          }
                        },
                        label: 'User Name',
                        prefix: Icons.person,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: emailController,
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
                        label: 'Email Address',
                        prefix: Icons.email_outlined,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        suffix: WorkableRegisterCubit.get(context).suffix,
                        onSubmit: (value) {},
                        isPassword: WorkableRegisterCubit.get(context).isPassword,
                        suffixPressed: () {
                          WorkableRegisterCubit.get(context).changePasswordVisibility();
                        },
                        label: 'Password',
                        prefix: Icons.lock_outline,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (String value) {
                          var phoneRegix = RegExp(r"^(010|011|012)\d{8}$");
                          if (value.isEmpty) {
                            return 'please enter your phone';
                          }
                          if (!phoneRegix.hasMatch(value)) {
                            return 'please enter a valid phone';
                          }
                        },
                        label: 'Phone',
                        prefix: Icons.phone,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      ListTile(
                        title: const Text('What is your gender? '),
                        trailing: DropdownButton<String>(
                          // Must be one of items.value.
                          value: WorkableRegisterCubit.get(context).isMale != null &&
                                  WorkableRegisterCubit.get(context).isMale!
                              ? 'Male'
                              : 'Female',
                          onChanged: (newValue) {
                            if (newValue != null) {
                              WorkableRegisterCubit.get(context).changeUserGenderIsMale(newValue);
                            }
                          },
                          items: _dropDownMenuItems,
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      ListTile(
                        title: const Text('What is your role? '),
                        trailing: IS_APPLICANT ? const Text('Applicant') : const Text('HR'),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      state is! WorkableRegisterLoadingState
                          ? defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  WorkableRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              text: 'register',
                              isUpperCase: true,
                            )
                          : const Center(child: CircularProgressIndicator()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account?',
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
