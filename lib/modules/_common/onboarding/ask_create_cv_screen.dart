import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/shared/components/components.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../_applicant/applicant_main_layout/layout/applicant_layout.dart';
import '../../_applicant/create_cv_layout/create_cv_personal_info/create_cv_personal_info_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class AskCreateCvScreen extends StatelessWidget {
  const AskCreateCvScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkableCubit, WorkableStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: WorkableCubit.get(context).model != null
              ? Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.05,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: ElevatedButton(
                        onPressed: (){
                          navigateAndFinish(context, const ApplicantLayout());
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: HexColor('1B74BB'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                        child: const Text(
                          "Skip",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    )

                  ],),
              ),
              const SizedBox(
                height: 15,
              ),
              const Image(
                image: AssetImage('assets/images/cv.png'),
                width: 300,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                'Create your CV',
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
                        'Create your CV in order to have preference for job acceptance.',
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
                            navigateTo(context, const CreateCVPersonalInfoScreen());
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                          child: Text(
                            "Create Cv",
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
          )
              : const Center(child: CircularProgressIndicator()),
        );
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
