import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'job_model.dart';

class JobSearch {
  var icons = [
    'assets/IconsImage/certicraft.png',
    'assets/IconsImage/beanworks.jpeg',
    'assets/IconsImage/mailchimp.jpeg',
    'assets/IconsImage/mozila.png',
    'assets/IconsImage/reddit.jpeg',
  ];
  Stream<List<JobModel>> initSearching(
          {required String textEntered, required String fieldName}) =>
      FirebaseFirestore.instance
          .collection('jobs')
          .where(fieldName, isGreaterThanOrEqualTo: textEntered)
          .where(fieldName, isLessThan: '${textEntered}z')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => JobModel.fromJson(doc.data()))
              .toList());

  Widget buildJob(JobModel job) {
    return GestureDetector(
      // onTap: () {
      //   Navigator.push(
      //     context as BuildContext,
      //     MaterialPageRoute(builder: (context) => JobDetail(job: job)),
      //   );
      // },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
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
                          child: Image.asset(icons[Random().nextInt(5)]),
                        )),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(job.jobTitle!,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500)),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(job.position!,
                                style: TextStyle(color: Colors.grey[500])),
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
                            color: false
                                ? Colors.red.shade100
                                : Colors.grey.shade300,
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
                                ))),
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
                        padding:
                            const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade200),
                        child: Text(
                          job.jobType!,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding:
                            const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color:
                                Color(int.parse("0xffff0000")).withAlpha(20)),
                        child: Text(
                          "4 Experience",
                          style:
                              TextStyle(color: Color(int.parse("0xffff0000"))),
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
            )
          ],
        ),
      ),
    );
  }

  Widget streamBuilder(String searchedText, String FName) {
    return StreamBuilder<List<JobModel>>(
      stream: initSearching(textEntered: searchedText, fieldName: FName),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("error occured ${snapshot.error}");
        } else if (snapshot.hasData) {
          final job = snapshot.data;
          return Column(
            children: job!.map(buildJob).toList(),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
