import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/modules/_hr/hr_home/hr_home_screen.dart';
import 'package:gp2023/shared/other/bloc_observer.dart';
import 'package:gp2023/shared/constants/constants.dart';
import 'package:gp2023/shared/cubit/cubit.dart';
import 'package:gp2023/shared/cubit/states.dart';
import 'package:gp2023/shared/caching/cache_helper.dart';
import 'package:gp2023/shared/styles/themes.dart';
import 'package:intl/intl.dart';

import 'modules/_applicant/applicant_main_layout/layout/applicant_layout.dart';
import 'modules/_applicant/applicant_main_layout/layout/cubit/cubit.dart';
import 'modules/_applicant/applicant_main_layout/pages/applicant_apps_status/cubit/cubit.dart';
import 'modules/_applicant/applicant_main_layout/pages/applicant_home/cubit/cubit.dart';
import 'modules/_applicant/create_cv_layout/create_cv_Education/cubit/cubit.dart';
import 'modules/_applicant/create_cv_layout/create_cv_Experience/cubit/cubit.dart';
import 'modules/_applicant/create_cv_layout/create_cv_Skills/cubit/cubit.dart';
import 'modules/_applicant/create_cv_layout/create_cv_personal_info/cubit/cubit.dart';
import 'modules/_common/filter/cubit/cubit.dart';
import 'modules/_common/onboarding/first_app_screen.dart';
import 'modules/_common/onboarding/cubit/cubit.dart';
import 'modules/_common/signup/cubit/cubit.dart';
import 'modules/_hr/company_regiseter/company_register_screen.dart';
import 'modules/_hr/company_regiseter/cubit/cubit.dart';
import 'modules/_hr/hr_home/cubit/cubit.dart';
import 'modules/_hr/job_applications/cubit/cubit.dart';

bool IS_APPLICANT = false;
bool IS_NEW_USER = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  Widget widget;
  uId = CacheHelper.getData(key: 'uId');

  if (uId != null) {
    IS_APPLICANT = CacheHelper.getData(key: 'isApplicant');

    if (IS_APPLICANT) {
      print('xxxxx hi 0');
      widget = const ApplicantLayout();
    } else {
      print('oooo cached company name in main!: ${CacheHelper.getData(key: 'companyName')}');
      if (CacheHelper.getData(key: 'companyName') != "NONE") {
        print('xxxxx hi 1');
        widget = const HrHomeScreen();
      } else {
        print('xxxxx hi 2');
        widget = const CompanyRegisterScreen();
      }
    }
  } else {
    widget = const FirstAppScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;

  const MyApp({
    Key? key,
    this.isDark = false,
    required this.startWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ApplicantionsStatesCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => HrRegisterCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => WorkableRegisterCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
        BlocProvider(
          create: (BuildContext context) => WorkableCubit()..getUserData(),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              ApplicantCubit()..getApplicantString(),
        ),
        BlocProvider(
          create: (BuildContext context) => HrCubit()..getCompanyJobPosts(),
        ),
        BlocProvider(
          create: (BuildContext context) => ApplicantRegisterCubit()
            ..getApplicantRegisterString()
            ..getAllJobs(),
        ),
        BlocProvider(
          create: (BuildContext context) => FilterCubit()
            ..fromDateTimeController.text =
                DateFormat.yMMMd().format(DateTime.now()).toString()
            ..toDateTimeController.text =
                DateFormat.yMMMd().format(DateTime.now()).toString(),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              CreateCVPersonalInfoCubit()..setRegisterData(),
        ),
        BlocProvider(
            create: (BuildContext context) => CreateCVEducationCubit()),
        BlocProvider(
            create: (BuildContext context) => CreateCVExperienceCubit()),
        BlocProvider(
            create: (BuildContext context) => CreateCVSkillsCubit()),
        BlocProvider(
          create: (BuildContext context) => JobApplicationsCubit(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
            //    home:ApplicantCreateSkillsHome(),
          );
        },
      ),
    );
  }
}
