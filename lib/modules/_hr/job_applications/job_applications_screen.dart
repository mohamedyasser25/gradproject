import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/shared/components/components.dart';

import '../../../shared/models/job_model.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'review_application_screen.dart';

class JobApplicationsScreen extends StatelessWidget {
  final JobModel job;

  JobApplicationsScreen({required this.job, Key? key}) : super(key: key);

  TextEditingController ctrlInterviewFinalReport = TextEditingController();

  bool isFirstBuild = true;

  @override
  Widget build(BuildContext context) {
    if (isFirstBuild) {
      JobApplicationsCubit.get(context).getJobApplications(job);
      isFirstBuild = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(job.jobTitle!),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: BlocBuilder<JobApplicationsCubit, JobApplicationsState>(
        builder: (context, state) {
          if (state is JobApplicationsInitialState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is JobApplicationsErrorState) {
            return Center(child: Text(state.error));
          } else if (state is JobApplicationsSuccessState) {
            if (state.apps.isEmpty) {
              return const Center(child: Text('No applications yet.'));
            } else {
              return ListView.separated(
                itemCount: state.apps.length,
                separatorBuilder: (_, i) => const SizedBox(height: 16),
                itemBuilder: (_, i) {
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
                                'Applicant name:',
                                style: TextStyle(fontSize: 12),
                              ),
                              const SizedBox(height: 5),
                              FutureBuilder(
                                future: JobApplicationsCubit.get(context)
                                    .getApplicantName(state.apps[i]),
                                initialData: 'Loading...',
                                builder: (context, snapshot) {
                                  return Text(
                                    snapshot.data!,
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
                        trailing: PopupMenuButton<int>(
                          onSelected: (index) {
                            switch (index) {
                              case 0:
                                navigateTo(
                                    context,
                                    ReviewApplicationScreen(
                                      application: state.apps[i],
                                      showBtns: true,
                                    ));
                                break;
                              case 1:
                                _showFinalReportSheet(context, state.apps[i]);
                                break;
                            }
                          },
                          itemBuilder: (context) => const [
                            PopupMenuItem<int>(value: 0, child: Text('Review CV')),
                            PopupMenuItem<int>(value: 1, child: Text('Final Report')),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          } else {
            return const Center(child: Text('unexpected error'));
          }
        },
      ),
    );
  }

  _showFinalReportSheet(context, application) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(top: 20),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Text(
                'Send Report',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: Container(
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
                      controller: ctrlInterviewFinalReport,
                      maxLine: 12,
                      label: 'write your final report',
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    defaultButton(
                      text: 'done',
                      function: () {
                        JobApplicationsCubit.get(context)
                            .sendFinalReportToApplicant(application, ctrlInterviewFinalReport.text);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
