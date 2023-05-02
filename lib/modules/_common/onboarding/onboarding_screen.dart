import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/shared/components/components.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../_applicant/applicant_main_layout/layout/applicant_layout.dart';
import 'ask_create_cv_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkableCubit, WorkableStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: WorkableCubit.get(context).model != null ? Column(
            children: [
              const SizedBox(
                height: 70,
              ),
              const Image(
                image: AssetImage('assets/images/start.jpg'),
                width: 300,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                'Explore and find the best career for you!',
                style: TextStyle(
                    color: HexColor('#000000'),
                    fontWeight: FontWeight.w600,
                    fontSize: 30),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: HexColor('1B74BB'),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(
                        MediaQuery.of(context).size.width * 0.06),
                    topLeft: Radius.circular(
                        MediaQuery.of(context).size.width * 0.06),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.06,
                    horizontal: MediaQuery.of(context).size.width * 0.06,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Prepare for and secure your ideal internship, placement, or graduate position.',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: ElevatedButton(
                          onPressed: (){
                            navigateAndFinish(context, const AskCreateCvScreen());
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                          child: Text(
                            "Get Started",
                            style: TextStyle(
                                color: HexColor('1B74BB'),
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ) : const Center(child: CircularProgressIndicator()),);
      },
    );
  }

  Widget Columns(BuildContext context) {
    return Column(children: [
      const Image(
        image: AssetImage('assets/images/hang.png'),
        width: double.infinity,
        height: 300,
      ),
      const SizedBox(
        height: 30,
      ),
      defaultButton(
        function: () {
          navigateTo(context, const ApplicantLayout());
        },
        text: "save And Continue",
        background: const Color(0xff1B75BC),
        radius: 50,
        width: 300,
      )
    ]);
  }
}
