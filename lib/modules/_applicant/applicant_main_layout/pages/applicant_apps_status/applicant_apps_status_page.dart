import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/modules/_common/job_details/job_details_screen.dart';
import 'package:gp2023/shared/models/JobApplicationModel.dart';
import 'package:gp2023/shared/models/job_model.dart';

import '../../../../../shared/components/components.dart';
import '../../../../../shared/widgets/date_picker.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ApplicantAppsStatusPage extends StatelessWidget {
  ApplicantAppsStatusPage({Key? key}) : super(key: key);

  bool isFirstBuild = true;

  @override
  Widget build(BuildContext context) {
    if (isFirstBuild) {
      ApplicantionsStatesCubit.get(context).getUserApplications();
      isFirstBuild = false;
    }

    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: const [
                Tab(text: 'Accepted'),
                Tab(text: 'Rejected'),
                Tab(text: 'Pending'),
              ],
            ),
            backgroundColor: Colors.blue,
            title: Text(
              'Application Status',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: BlocBuilder<ApplicantionsStatesCubit, ApplicantionsStatusStates>(
            builder: (context, state) {
              if (state is ApplicantionsStatusInitialState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is UserApplicationsErrorState) {
                return Center(child: Text(state.err));
              } else if (state is UserApplicationsSuccessState) {
                if (state.apps.isEmpty) {
                  return const Center(child: Text('No applications yet.'));
                } else {
                  return TabBarView(children: [
                    ListView.separated(
                      itemCount: _getRejectedApps(state.apps).length,
                      separatorBuilder: (_, i) => const SizedBox(height: 16),
                      itemBuilder: (_, i) {
                        List<JobApplicationModel> apps = _getRejectedApps(state.apps);
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Card(
                            elevation: 0,
                            color: Colors.blue.withOpacity(0.1),
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Job Title:',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    const SizedBox(height: 5),
                                    FutureBuilder(
                                      future: ApplicantionsStatesCubit.get(context).getJob(apps[i]),
                                      builder: (context, AsyncSnapshot<dynamic> snapshot) {
                                        return Text(
                                          '${snapshot.data?['jobTitle']}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              trailing: InkWell(
                                onTap: () async {
                                  final String jobAppId =
                                      await ApplicantionsStatesCubit.get(context)
                                          .getJobAppId(apps[i]);
                                  final String interviewDate =
                                      await ApplicantionsStatesCubit.get(context)
                                          .getRepliedInterviewDate(jobAppId);
                                  _showInterViewDateSheet(context, interviewDate);
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  elevation: 0,
                                  color: Colors.green.withOpacity(0.5),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                    child: Text(
                                      'Interview',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () async {
                                Map<String, dynamic> m =
                                    await ApplicantionsStatesCubit.get(context).getJob(apps[i]);
                                navigateTo(context, JobDetailsScreen(job: JobModel.fromJson(m)));
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    ListView.separated(
                      itemCount: _getAcceptedApps(state.apps).length,
                      separatorBuilder: (_, i) => const SizedBox(height: 16),
                      itemBuilder: (_, i) {
                        List<JobApplicationModel> apps = _getAcceptedApps(state.apps);
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Card(
                            elevation: 0,
                            color: Colors.blue.withOpacity(0.1),
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Job Title:',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    const SizedBox(height: 5),
                                    FutureBuilder(
                                      future: ApplicantionsStatesCubit.get(context).getJob(apps[i]),
                                      builder: (context, AsyncSnapshot<dynamic> snapshot) {
                                        return Text(
                                          '${snapshot.data?['jobTitle']}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              trailing: InkWell(
                                onTap: () async {
                                  final String jobAppId =
                                      await ApplicantionsStatesCubit.get(context)
                                          .getJobAppId(apps[i]);
                                  final String feedback =
                                      await ApplicantionsStatesCubit.get(context)
                                          .getRepliedFeedback(jobAppId);
                                  _showInterFeedbackSheet(context, feedback);
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  elevation: 0,
                                  color: Colors.red.withOpacity(0.5),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                    child: Text(
                                      'Feedback',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () async {
                                Map<String, dynamic> m =
                                    await ApplicantionsStatesCubit.get(context).getJob(apps[i]);
                                navigateTo(context, JobDetailsScreen(job: JobModel.fromJson(m)));
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    ListView.separated(
                      itemCount: _getPendingApps(state.apps).length,
                      separatorBuilder: (_, i) => const SizedBox(height: 16),
                      itemBuilder: (_, i) {
                        List<JobApplicationModel> apps = _getPendingApps(state.apps);
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Card(
                            elevation: 0,
                            color: Colors.blue.withOpacity(0.1),
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Job Title:',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    const SizedBox(height: 5),
                                    FutureBuilder(
                                      future: ApplicantionsStatesCubit.get(context).getJob(apps[i]),
                                      builder: (context, AsyncSnapshot<dynamic> snapshot) {
                                        return Text(
                                          '${snapshot.data?['jobTitle']}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              trailing: InkWell(
                                onTap: () async {
                                  showToast(text: 'pending...', state: ToastStates.WARNING);
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  elevation: 0,
                                  color: Colors.grey.withOpacity(0.5),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                    child: Text(
                                      'Pending',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () async {
                                Map<String, dynamic> m =
                                    await ApplicantionsStatesCubit.get(context).getJob(apps[i]);
                                navigateTo(context, JobDetailsScreen(job: JobModel.fromJson(m)));
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ]);
                }
              } else {
                return const Center(child: Text('unexpected error'));
              }
            },
          ),
        ));
  }

  List<JobApplicationModel> _getAcceptedApps(List<JobApplicationModel> apps) {
    List<JobApplicationModel> acceptedApps = [];
    for (var app in apps) {
      if (app.status == 'interview') {
        acceptedApps.add(app);
      }
    }
    return acceptedApps;
  }

  List<JobApplicationModel> _getRejectedApps(List<JobApplicationModel> apps) {
    List<JobApplicationModel> rejectedApps = [];
    for (var app in apps) {
      if (app.status == 'feedback') {
        rejectedApps.add(app);
      }
    }
    return rejectedApps;
  }

  List<JobApplicationModel> _getPendingApps(List<JobApplicationModel> apps) {
    List<JobApplicationModel> pendingApps = [];
    for (var app in apps) {
      if (app.status == 'pending') {
        pendingApps.add(app);
      }
    }
    return pendingApps;
  }

  _showInterViewDateSheet(context, String interViewDate) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SizedBox(
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: const [
                    Text(
                      'You have an Interview at...',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                DatePicker(
                  enabled: false,
                  datePickerController: TextEditingController(text: interViewDate),
                  onSelectDate: (val) {},
                  hintText: '',
                  trailingIcon: const Icon(Icons.date_range, size: 20),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                  ),
                  textStyle: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _showInterFeedbackSheet(context, String feedback) {
    print('hiiii');
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      'HR Feedback...',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                defaultFormField(
                  isClickable: false,
                  controller: TextEditingController(text: feedback),
                  maxLine: 12,
                  label: 'write your feedback',
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        );
      },
    );
  }

  _showFinalReportSheet(context, String report) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      'Final Report',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                defaultFormField(
                  controller: TextEditingController(text: report),
                  maxLine: 12,
                  label: 'write your final report',
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
