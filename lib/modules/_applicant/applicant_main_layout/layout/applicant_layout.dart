import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ApplicantLayout extends StatelessWidget {
  const ApplicantLayout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApplicantCubit, ApplicantStates>(
        listener: (context, state) {},
        builder: (context, state) {
          // String appBarText =
          //  CacheHelper.getData(key: 'name') + ' !' ?? 'hi, User!';
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: ApplicantCubit.get(context).currentIndex,
              onTap: (index) {
                ApplicantCubit.get(context).changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  backgroundColor: Color(0xff1B75BC),
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  backgroundColor: Color(0xff1B75BC),
                  icon: Icon(
                    Icons.file_copy_outlined,
                  ),
                  label: 'Application states',

                ),
                BottomNavigationBarItem(
                  backgroundColor: Color(0xff1B75BC),
                  icon: Icon(
                    Icons.favorite_outlined,
                  ),
                  label: 'Saved jobs',

                ),
              ],
            ),
            body: ApplicantCubit.get(context).screens[ApplicantCubit.get(context).currentIndex],
            drawer: initiateDrawer(context),

          );
        });
  }
}
