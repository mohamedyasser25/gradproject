import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/shared/components/components.dart';
import 'package:gp2023/shared/constants/constants.dart';
import 'package:intl/intl.dart';

import '../../../shared/styles/colors.dart';
import '../../_common/job_details/job_details_screen.dart';
import '../job_applications/job_applications_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class HrHomeScreen extends StatelessWidget {
  const HrHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    var searchController = TextEditingController();

    return BlocConsumer<HrCubit, HrStates>(
      listener: (_, state) {
        if (state is HrSaveSuccessState) {
          Navigator.pop(context);
          HrCubit.get(context).getCompanyJobPosts();
        }
      },
      builder: (_, state) {
        return Scaffold(
          key: scaffoldKey,
          drawer: initiateHrDrawer(context),
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: Column(
                  children: [
                    BlocBuilder<HrCubit, HrStates>(
                      builder: (_, state) {
                        if (state is HrInitialState) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state is HrGetJobsErrorState) {
                          return Center(child: Text(state.error));
                        } else if (state is HrGetJobsSuccessState) {
                          return Expanded(
                            child: CustomScrollView(
                              slivers: <Widget>[
                                const SliverAppBar(
                                  expandedHeight: 60.0,
                                  backgroundColor: defaultColor,
                                  flexibleSpace: FlexibleSpaceBar(
                                    centerTitle: true,
                                    title: Padding(
                                      padding: EdgeInsets.only(left: 5, right: 5, top: 20),
                                      child: Text('My Jobs'),
                                    ),
                                  ),
                                ),
                                const SliverPadding(padding: EdgeInsets.only(top: 10)),
                                SliverPadding(
                                  padding: const EdgeInsets.only(top: 10),
                                  sliver: SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => JobDetailsScreen(
                                                  job: state.jobs[index],
                                                ),
                                              ),
                                            );
                                          },
                                          child: Card(
                                            clipBehavior: Clip.antiAlias,
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: Column(
                                                children: [
                                                  const Image(
                                                    image: NetworkImage(
                                                        'https://cdn.searchenginejournal.com/wp-content/uploads/2017/06/shutterstock_268688447-760x400.webp'),
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  ListTile(
                                                    title: Text(state.jobs[index].jobTitle!,
                                                        style: const TextStyle(
                                                            fontWeight: FontWeight.bold),
                                                        textAlign: TextAlign.start),
                                                    subtitle: Text(
                                                      state.jobs[index].jobDescription!,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    trailing: InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  JobApplicationsScreen(
                                                                      job: state.jobs[index])),
                                                        );
                                                      },
                                                      child: Card(
                                                        elevation: 0,
                                                        color: Colors.blue.withOpacity(0.1),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(50)),
                                                        child: const Padding(
                                                          padding: EdgeInsets.all(10),
                                                          child: Text('See Applications'),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      childCount: state.jobs.length,
                                    ),
                                  ),
                                ),
                                SliverToBoxAdapter(
                                    child: SizedBox(
                                  height: 50,
                                )),
                              ],
                            ),
                          );
                        } else {
                          return const Text('unexpected error');
                        }
                      },
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Card(
                  elevation: 10,
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: SizedBox(
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.home,
                                  color: Colors.blueAccent,
                                ),
                                onPressed: () {
                                  // Todo
                                },
                              ),
                              Text(
                                'Home',
                                style: TextStyle(color: Colors.blueAccent),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              FloatingActionButton(
                                mini: true,
                                elevation: 0,
                                backgroundColor: Colors.blue.withOpacity(0.1),
                                child: const Icon(Icons.add, color: Colors.lightBlue),
                                onPressed: () => _showCreateNewJobSheet(context),
                              ),
                              Text(
                                'Post Job',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.add,
                              color: Colors.transparent,
                            ),
                            onPressed: () {
                              // Todo
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  _showCreateNewJobSheet(BuildContext context) {
    var cubit = HrCubit.get(context);

    var formKey = GlobalKey<FormState>();
    var jobDescriptionController = TextEditingController();
    var salaryController = TextEditingController();
    var endDateController = TextEditingController();

    void handleSkillsSelected(List<String> selectedSkills) {
      cubit.skillsList = selectedSkills;
    }

    void addItemToList(List<String> selectedSkills) {
      cubit.itemsList = selectedSkills;
    }

    final List<DropdownMenuItem<String>> jobTypeDropDownMenuItems = jopType
        .map(
          (String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
            ),
          ),
        )
        .toList();

    final List<DropdownMenuItem<String>> jobTitleDropDownMenuItems =
        jopTitlesList.map((String value) {
      if (value.toLowerCase() == 'it' ||
          value.toLowerCase() == 'finance' ||
          value.toLowerCase() == 'medicine' ||
          value.toLowerCase() == 'other') {
        return DropdownMenuItem<String>(
            value: value,
            enabled: false,
            child: Text(
              value,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ));
      } else {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }
    }).toList();

    final List<DropdownMenuItem<String>> positionsDropDownMenuItems = positionsList
        .map(
          (String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
            ),
          ),
        )
        .toList();

    final List<DropdownMenuItem<String>> experienceDropDownMenuItems = experienceLevel
        .map(
          (String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
            ),
          ),
        )
        .toList();

    showModalBottomSheet(
      context: context,
      elevation: 10,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(top: 20),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Text(
                'Post New Job',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
                  alignment: Alignment.bottomCenter,
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        dropDownListTitle('Job Title'),
                        const SizedBox(
                          height: 10,
                        ),
                        defaultDropDownList(
                            value: cubit.jobTitleValue,
                            onChange: (value) {
                              cubit.changeJobTitle(value);
                            },
                            items: jobTitleDropDownMenuItems),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: jobDescriptionController,
                          type: TextInputType.text,
                          maxLine: 12,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'description must not be empty';
                            }
                          },
                          label: 'Job Description',
                          prefix: Icons.line_style,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            controller: salaryController,
                            type: TextInputType.number,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'job salary must not be empty';
                              }
                            },
                            label: 'Job Salary in EGP',
                            prefix: Icons.currency_bitcoin),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: endDateController,
                          type: TextInputType.datetime,
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2200))
                                .then((value) {
                              endDateController.text =
                                  DateFormat('yyyy-MM-dd').format(value!).toString();
                            });
                          },
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Date must not be empty';
                            }
                          },
                          label: 'End Date',
                          prefix: Icons.watch_later_outlined,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        dropDownListTitle('Job Type'),
                        const SizedBox(
                          height: 10,
                        ),
                        defaultDropDownList(
                            value: cubit.jobTypeValue,
                            onChange: (value) => cubit.changeJobType(value),
                            items: jobTypeDropDownMenuItems),
                        const SizedBox(
                          height: 15.0,
                        ),
                        dropDownListTitle('Positions'),
                        const SizedBox(
                          height: 10,
                        ),
                        defaultDropDownList(
                            value: cubit.positionValue,
                            onChange: (value) => cubit.changePositions(value),
                            items: positionsDropDownMenuItems),
                        const SizedBox(
                          height: 15.0,
                        ),
                        dropDownListTitle('Experience'),
                        const SizedBox(
                          height: 10,
                        ),
                        defaultDropDownList(
                            value: cubit.experienceValue,
                            onChange: (value) => cubit.changeExperience(value),
                            items: experienceDropDownMenuItems),
                        const SizedBox(
                          height: 15.0,
                        ),
                        dropDownListTitle('Skills'),
                        const SizedBox(
                          height: 10,
                        ),
                        MyAutocompleteField(
                          onSkillsSelected: handleSkillsSelected,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        ListField(
                          onSkillsSelected: addItemToList,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              cubit.createJob(
                                jobTitle: cubit.jobTitleValue,
                                jobDescription: jobDescriptionController.text,
                                salary: num.parse(
                                  salaryController.text,
                                ),
                                endDate: DateTime.parse(
                                  endDateController.text,
                                ),
                                jobTypeValue: cubit.jobTypeValue,
                                positionValue: cubit.positionValue,
                                experienceValue: cubit.experienceValue,
                                skillsList: cubit.skillsList as List<String>,
                                requirementList: cubit.itemsList as List<String>,
                              );
                            } else {
                              showToast(text: 'enter all data', state: ToastStates.ERROR);
                            }
                          },
                          text: 'Create a new job',
                          isUpperCase: false,
                        ),
                      ],
                    ),
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
