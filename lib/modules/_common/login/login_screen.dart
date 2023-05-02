import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/modules/_common/onboarding/first_app_screen.dart';
import 'package:gp2023/modules/_hr/hr_home/hr_home_screen.dart';
import '../../../main.dart';
import '../../../shared/caching/cache_helper.dart';
import '../../../shared/components/components.dart';
import '../../_applicant/applicant_main_layout/layout/applicant_layout.dart';
import '../../_hr/company_regiseter/company_register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => WorkableLoginCubit(),
      child: BlocConsumer<WorkableLoginCubit, WorkableLoginStates>(
        listener: (context, state) {
          if (state is WorkableLoginErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.ERROR,
            );
          }
          if (state is WorkableLoginSuccessState &&
              (CacheHelper.getData(key: 'email') != null ||
                  CacheHelper.getData(key: 'name') != null)) {
            if (IS_APPLICANT) {
              CacheHelper.saveData(
                key: 'uId',
                value: state.uId,
              )
                  .then((value) => CacheHelper.saveData(
                        key: 'companyName',
                        value: "NONE",
                      ))
                  .then((value) {
                navigateAndFinish(
                  context,
                  const ApplicantLayout(),
                );
              });
            } else {
              CacheHelper.saveData(
                key: 'uId',
                value: state.uId,
              ).then((value) {
                if (CacheHelper.getData(key: 'companyName') == "NONE") {
                  navigateAndFinish(
                    context,
                    const CompanyRegisterScreen(),
                  );
                } else {
                  navigateAndFinish(
                    context,
                    const HrHomeScreen(),
                  );
                }
              });
            }
          }
        },
        builder: (context, state) {
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
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: Colors.black,
                              ),
                        ),
                        Text(
                          'Login to find your next job!',
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'please enter your email address';
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
                          suffix: WorkableLoginCubit.get(context).suffix,
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              // WorkableLoginCubit.get(context).userLogin(
                              //   email: emailController.text,
                              //   password: passwordController.text,
                              // );
                            }
                          },
                          isPassword:
                              WorkableLoginCubit.get(context).isPassword,
                          suffixPressed: () {
                            WorkableLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'password is too short';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        state is! WorkableLoginLoadingState
                        ? defaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              WorkableLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          text: 'login',
                          isUpperCase: true,
                        )
                        :const Center(child: CircularProgressIndicator()),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account?',
                            ),
                            defaultTextButton(
                              function: () {
                                navigateTo(
                                  context,
                                  const FirstAppScreen(),
                                );
                              },
                              text: 'register',
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
      ),
    );
  }
}
