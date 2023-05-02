import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gp2023/shared/components/components.dart';
import 'package:gp2023/shared/caching/cache_helper.dart';

import 'package:gp2023/shared/styles/colors.dart';

import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../../main.dart';
import '../../../../shared/models/jopTitleModel.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class CreateCVSkillsScreen extends StatelessWidget {
  const CreateCVSkillsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateCVSkillsCubit,
        CreateCVSkillsStates>(listener: (context, state) {
      if (state is CreateCVSkillsErrorState) {
        showToast(
          text: state.error,
          state: ToastStates.ERROR,
        );
      }
      if (state is CreateCVSkillsSuccessState &&
          IS_APPLICANT &&
          (CacheHelper.getData(key: 'email') != null ||
              CacheHelper.getData(key: 'name') != null)) {
        CacheHelper.saveData(
          key: 'uId',
          value: state.uId,
        ).then((value) {});
      }
    }, builder: (context, state) {
      var cubit = CreateCVSkillsCubit.get(context);

      final skills = cubit.SkillsItems.map((element) =>
          MultiSelectItem<SkillsDataModel>(element, element.name)).toList();

      return Scaffold(
        appBar: AppBar(
          title: const Text(
            ' Skills',
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
                        'Add your Skills',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      MultiSelectDialogField(
                        validator: (value) {
                          if(value ==null||value==[]||cubit.selectedSkills==[]){
                            return
                              'Please fill this field';
                          }

                          return null;
                        },
                        onConfirm: (val) {
                          cubit.selectSkill(val, context);
                        },
                        title: Container(
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          color: primaryColor,
                          child: const Text(
                            'Skills',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        buttonText: const Text(
                          'Skills',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                              fontWeight: FontWeight.normal),
                        ),
                        buttonIcon: const Icon(Icons.arrow_drop_down_sharp),
                        itemsTextStyle: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                        dialogWidth: MediaQuery.of(context).size.width * 0.7,
                        dialogHeight: MediaQuery.of(context).size.height * 0.5,
                        backgroundColor: Colors.blueGrey[50],
                        cancelText: const Text(
                          'CANCEL',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w500),
                        ),
                        items: skills,
                        initialValue: cubit.selectedSkills,
                        decoration: BoxDecoration(

                          borderRadius: const BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                          color: Colors.white38,
                          border: Border.all(
                            color: Colors.black54,
                            style: BorderStyle.solid,
                            width: 1.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Center(
                        child: defaultButton(
                          function: () {
                            if (cubit.formKey.currentState!.validate()) {
                            if(IS_NEW_USER) {
                              cubit.skillsCreate(
                                  context,
                                  uId: CacheHelper.getData(key: 'uId')
                              );
                            }
                              cubit.selectedSkills = [];
                            } else {
                              showToast(text: 'Select Skills please', state: ToastStates.ERROR);
                              cubit.selectedSkills = [];
                            }
                          },
                          text: 'Save',
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
