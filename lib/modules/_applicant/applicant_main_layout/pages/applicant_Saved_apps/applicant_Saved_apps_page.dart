import 'package:flutter/material.dart';

class ApplicantSavedAppsPage extends StatelessWidget {
  const ApplicantSavedAppsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Text('Saved Jobs'), CircularProgressIndicator()]));
  }
}
