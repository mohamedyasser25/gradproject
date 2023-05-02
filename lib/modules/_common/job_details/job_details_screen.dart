import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp2023/shared/components/components.dart';
import 'package:gp2023/shared/caching/cache_helper.dart';

import '../../../main.dart';
import '../../../shared/models/job_model.dart';
import '../../_hr/job_applications/job_applications_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class JobDetailsScreen extends StatelessWidget {
  final JobModel job;

  const JobDetailsScreen({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => JobDetailsCubit(),
        child: BlocConsumer<JobDetailsCubit, JobDetailsStates>(
            listener: (context, state) {
          if (state is JobApplySuccessState) {
            showToast(
                text: 'job applied successfully', state: ToastStates.SUCCESS);
            Navigator.pop(context);
          }
        }, builder: (context, state) {
          var cubit = JobDetailsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(job.jobTitle!),
              backgroundColor: Colors.blue,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: Image.asset(
                            job.jobIcon!,
                            fit: BoxFit.cover,
                            height: 100,
                            width: 100,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Job Description:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        job.jobDescription!,
                        style:
                            const TextStyle(fontSize: 12, fontFamily: "Jannah"),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Salary:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        job.salary.toString(),
                        style:
                            const TextStyle(fontSize: 12, fontFamily: "Jannah"),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Start Date:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        job.startDate.toString(),
                        style:
                            const TextStyle(fontSize: 12, fontFamily: "Jannah"),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'End Date:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        job.endDate.toString(),
                        style:
                            const TextStyle(fontSize: 12, fontFamily: "Jannah"),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Job Type:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        job.jobType!,
                        style:
                            const TextStyle(fontSize: 12, fontFamily: "Jannah"),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Experience Years:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        job.experienceYears!,
                        style:
                            const TextStyle(fontSize: 12, fontFamily: "Jannah"),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Job Skills:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children: job.jobSkills!
                          .map<Widget>(
                            (skill) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(children: [
                                Icon(
                                  Icons.circle,
                                  size: 10,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      skill,
                                      style: const TextStyle(
                                          fontSize: 12, fontFamily: "Jannah"),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Job Requirements:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children: job.jobRequirement!
                          .map<Widget>(
                            (requirement) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(children: [
                                Icon(
                                  Icons.circle,
                                  size: 10,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      requirement,
                                      style: const TextStyle(
                                          fontSize: 12, fontFamily: "Jannah"),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Position:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        job.position!,
                        style:
                            const TextStyle(fontSize: 12, fontFamily: "Jannah"),
                      ),
                    ),
                    IS_APPLICANT
                        ? Center(
                            child: defaultButton(
                              function: () {
                                cubit.applyForjob(jobId: job.id!);
                              },
                              text: "Apply for this job",
                            ),
                          )
                        : Center(
                            child: defaultButton(
                              function: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          JobApplicationsScreen(job: job)),
                                );
                              },
                              text: "See Job Applications",
                            ),
                          ),
                  ],
                ),
              ),
            ),
          );
        },),);
  }
}
