import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/caching/cache_helper.dart';
import '../../../../../shared/components/components.dart';
import '../../../../../shared/models/job_model.dart';
import '../../../../_common/filter/filterHome.dart';
import '../../../../_common/job_details/job_details_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ApplicantHomePage extends StatefulWidget {
  const ApplicantHomePage({Key? key}) : super(key: key);

  @override
  State<ApplicantHomePage> createState() => _ApplicantHomePageState();
}

class _ApplicantHomePageState extends State<ApplicantHomePage> {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ApplicantRegisterCubit.get(context).listOfJobs == null
        ? Center(child: CircularProgressIndicator())
        : CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 160.0,
                backgroundColor: const Color(0xff1B75BC),
                shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 5, top: 20, bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Hi, ${CacheHelper.getData(key: 'name')} !'),
                      ],
                    ),
                  ),
                ),
              ),
              const SliverPadding(padding: EdgeInsets.only(top: 10)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: defaultFormField(
                    controller: searchController,
                    type: TextInputType.emailAddress,
                    label: 'Search',
                    prefix: Icons.search,
                    suffix: Icons.sort,
                    suffixPressed: () {
                      navigateTo(context, const FilterHome());
                    },
                    onChange: (value) {
                      ApplicantRegisterCubit.get(context).changeListSearch(value, context);
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                  child: Text(
                    'Recommended jobs',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              // SliverPadding(
              //     padding: EdgeInsets.only(top: 10),
              //     sliver: SliverList(
              //         delegate: SliverChildBuilderDelegate((context, index) {
              //       GestureDetector(
              //         onTap: () {},
              //         child: Card(
              //           clipBehavior: Clip.antiAlias,
              //           child: SizedBox(
              //             width: double.infinity,
              //             child: Column(
              //               children: [
              //                 Image(
              //                   image: NetworkImage(
              //                       'https://cdn.searchenginejournal.com/wp-content/uploads/2017/06/shutterstock_268688447-760x400.webp'),
              //                 ),
              //                 Divider(),
              //                 SizedBox(
              //                   height: 10,
              //                 ),
              //                 Text(
              //                     "${ApplicantRegisterCubit.get(context).searchList[index].jobTitle}(${ApplicantRegisterCubit.get(context).searchList[index].salary} EGP)",
              //                     style: TextStyle(fontWeight: FontWeight.bold),
              //                     textAlign: TextAlign.start),
              //                 Text(
              //                     "As ${ApplicantRegisterCubit.get(context).searchList[index].role} starting from ${ApplicantRegisterCubit.get(context).searchList[index].startDate})",
              //                     style: TextStyle(fontWeight: FontWeight.bold),
              //                     textAlign: TextAlign.start),
              //                 SizedBox(
              //                   height: 10,
              //                 ),
              //                 Text(
              //                     "Job type: ${ApplicantRegisterCubit.get(context).searchList[index].role}",
              //                     style: TextStyle(fontWeight: FontWeight.bold),
              //                     textAlign: TextAlign.start),
              //                 SizedBox(
              //                   height: 10,
              //                 ),
              //                 Center(
              //                     child: SizedBox(
              //                   width: double.infinity / 2,
              //                   child: Text(
              //                       "${ApplicantRegisterCubit.get(context).searchList[index].description}"),
              //                 )),
              //                 Text('Recommended Jobs')
              //               ],
              //             ),
              //           ),
              //         ),
              //       );
              //     }))),
              SliverToBoxAdapter(
                child: BlocConsumer<ApplicantRegisterCubit, ApplicantRegisterStates>(
                  builder: (context, state) {
                    var cubit = ApplicantRegisterCubit.get(context);
                    return Column(
                      children: cubit.listOfJobs.map((job) => buildJob(context, job)).toList(),
                    );
                  },
                  listener: (context, state) => {},
                ),
              ),
            ],
          );
  }
}

var icons = [
  'assets/IconsImage/certicraft.png',
  'assets/IconsImage/beanworks.jpeg',
  'assets/IconsImage/mailchimp.jpeg',
  'assets/IconsImage/mozila.png',
  'assets/IconsImage/reddit.jpeg',
];

Widget buildJob(context, JobModel job) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context as BuildContext,
        MaterialPageRoute(builder: (context) => JobDetailsScreen(job: job)),
      );
    },
    child: Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 15),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 0,
          blurRadius: 2,
          offset: const Offset(0, 1),
        ),
      ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(children: [
                  SizedBox(
                      width: 60,
                      height: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(job.jobIcon!),
                      )),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(job.jobTitle!,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500)),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(job.position!, style: TextStyle(color: Colors.grey[500])),
                    ]),
                  )
                ]),
              ),
              GestureDetector(
                onTap: () {
                  // setState(() {
                  //   job.isMyFav = !job.isMyFav;
                  // });
                },
                child: AnimatedContainer(
                  height: 35,
                  padding: const EdgeInsets.all(5),
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: false ? Colors.red.shade100 : Colors.grey.shade300,
                      )),
                  child: Center(
                    child: false
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : Icon(
                            Icons.favorite_outline,
                            color: Colors.grey.shade600,
                          ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12), color: Colors.grey.shade200),
                      child: Text(
                        job.jobType!,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(int.parse("0xffff0000")).withAlpha(20)),
                      child: Text(
                        "4 Experience",
                        style: TextStyle(color: Color(int.parse("0xffff0000"))),
                      ),
                    )
                  ],
                ),
                Text(
                  "${DateTime.now().difference(job.startDate!).inDays} Days ago",
                  style: TextStyle(color: Colors.grey.shade800, fontSize: 12),
                )
              ],
            ),
          ),
          //   SizedBox(
          //     height: 20,
          //   ),
          //   Container(
          //     child: defaultButton(
          //         function: () {
          //           Navigator.push(
          //             context as BuildContext,
          //             MaterialPageRoute(
          //                 builder: (context) => HrApplication(job: job)),
          //           );
          //         },
          //         text: "View job details"),
          //   )
        ],
      ),
    ),
  );
}
