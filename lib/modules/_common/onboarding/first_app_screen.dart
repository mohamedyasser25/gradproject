import 'package:flutter/material.dart';
import 'package:gp2023/modules/_common/signup/cubit/cubit.dart';
import 'package:gp2023/modules/_common/signup/signup_screen.dart';
import 'package:gp2023/shared/components/components.dart';

import '../../../main.dart';
import '../../../shared/caching/cache_helper.dart';
import '../../../shared/constants/image_paths.dart';
import '../../_hr/company_regiseter/company_register_screen.dart';

class FirstAppScreen extends StatelessWidget {
  const FirstAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImagePaths.select_type_gif),
            const SizedBox(height: 12),
            const Text(
              'Join as a ...',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                IS_APPLICANT = true;
                CacheHelper.saveData(key: 'isApplicant', value: true);
                navigateTo(
                  context,
                  SignupScreen(),
                );
              },
              child: const Text('Applicant'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                IS_APPLICANT = false;
                CacheHelper.saveData(key: 'isApplicant', value: false);
                navigateTo(
                  context,
                  const CompanyRegisterScreen(),
                );
              },
              child: const Text('Company'),
            ),
          ],
        ),
      ),
    );
  }
}
