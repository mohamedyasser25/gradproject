import 'package:flutter/material.dart';
import 'package:gp2023/shared/models/JobApplicationModel.dart';
import 'package:intl/intl.dart';

import '../../../shared/components/components.dart';
import '../../../shared/widgets/date_picker.dart';
import 'cubit/cubit.dart';

class ReviewApplicationScreen extends StatelessWidget {
  static const id = 'ReviewApplicationScreen';

  final JobApplicationModel application;
  final bool showBtns;

  ReviewApplicationScreen({Key? key, required this.application, this.showBtns = false})
      : super(key: key);

  TextEditingController ctrlFeedback = TextEditingController();
  TextEditingController ctrlInterviewDate = TextEditingController();
  TextEditingController ctrlInterviewTime = TextEditingController();
  String selectedInterviewDate = '';
  String selectedInterviewTime = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CV',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Profile',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),
                      ),
                      FutureBuilder(
                        future: JobApplicationsCubit.get(context).getApplicantProfile(application),
                        builder: (_, AsyncSnapshot<dynamic> snapshot) {
                          return Text(
                            '${snapshot.data}',
                            style: const TextStyle(fontSize: 16),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Education',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),
                      ),
                      FutureBuilder(
                        future:
                            JobApplicationsCubit.get(context).getApplicantEducation(application),
                        builder: (_, AsyncSnapshot<dynamic> snapshot) {
                          return Text(
                            '${snapshot.data}',
                            style: const TextStyle(fontSize: 16),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Experience',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),
                      ),
                      FutureBuilder(
                        future:
                            JobApplicationsCubit.get(context).getApplicantExperience(application),
                        builder: (_, AsyncSnapshot<dynamic> snapshot) {
                          return Text(
                            '${snapshot.data}',
                            style: const TextStyle(fontSize: 16),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Skills',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),
                      ),
                      FutureBuilder(
                        future: JobApplicationsCubit.get(context).getApplicantSkills(application),
                        builder: (_, AsyncSnapshot<dynamic> snapshot) {
                          return Text(
                            '${snapshot.data}',
                            style: const TextStyle(fontSize: 16),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      if (showBtns)
                        Row(
                          children: [
                            Expanded(
                                child: defaultButton(
                                    function: () => _showSendInterViewSheet(context, application),
                                    text: 'Accept')),
                            const SizedBox(width: 10),
                            Expanded(
                                child: defaultButton(
                                    function: () => _showSendFeedbackSheet(context, application),
                                    text: 'Reject')),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showSendInterViewSheet(context, application) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(top: 20),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Text(
                'Send Feedback',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: SizedBox(
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: const [
                        Text(
                          'Interview Date & Time',
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
                      datePickerController: ctrlInterviewDate,
                      onSelectDate: (val) {
                        selectedInterviewDate = DateFormat.yMMMd().format(val).toString();
                        ctrlInterviewDate.text = DateFormat.yMMMd().format(val).toString();
                      },
                      hintText: 'Interview date',
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
                    defaultTimePicker(ctrlInterviewTime, context, (TimeOfDay val) {
                      selectedInterviewTime = '${val.hour}:${val.minute}';
                      ctrlInterviewTime.text = '${val.hour}:${val.minute}';
                    }, "select time"),
                    const SizedBox(
                      height: 50,
                    ),
                    defaultButton(
                      text: 'done',
                      function: () {
                        if (selectedInterviewDate.isNotEmpty && selectedInterviewTime.isNotEmpty) {
                          JobApplicationsCubit.get(context).sendInterviewToApplicant(
                              application, '$selectedInterviewDate  at $selectedInterviewTime');
                          Navigator.pop(context);
                        }
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

  _showSendFeedbackSheet(context, application) {
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
                'Send Feedback',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Feedback',
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
                      controller: ctrlFeedback,
                      maxLine: 12,
                      label: 'write your feedback',
                    ),
                    const SizedBox(height: 50),
                    defaultButton(
                      text: 'done',
                      function: () {
                        JobApplicationsCubit.get(context)
                            .sendFeedbackToApplicant(application, ctrlFeedback.text);
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
