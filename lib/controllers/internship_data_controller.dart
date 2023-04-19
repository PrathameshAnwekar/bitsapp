import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/internship_application.dart';
import 'package:bitsapp/models/internship_data.dart';
import 'package:bitsapp/services/logger_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InternshipDataController {
  static Future<void> postNewInternship(WidgetRef ref, BuildContext context,
      {required String title,
      required String description,
      required String posterUID,
      required List<String> skills,
      required String contactEmail,
      required String compensation}) async {
    dlog("Form is valid, posting new internship");
    final localUser = ref.read(localUserProvider);
    final internshipData = InternshipData(
        uid: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        description: description,
        applications: [],
        posterUID: posterUID,
        time: DateTime.now().millisecondsSinceEpoch,
        skills: skills,
        contactEmail: contactEmail,
        compensation: compensation);
    await ref
        .read(internshipDataProvider.notifier)
        .postInternship(internshipData, localUser.uid)
        .then((value) {
      dlog("Internship posted successfully");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Internship posted successfully')),
      );
      Navigator.of(context).pop();
    });
  }

  static Future<void> addApplication(
      {required WidgetRef ref,
      required BuildContext context,
      required String internshipUid,
      required String coverLetter,
      required String applicantUid}) async {
    final application = InternshipApplication(
        uid: applicantUid, coverLetter: coverLetter, status: "Pending");
    await ref
        .read(internshipDataProvider.notifier)
        .addApplication(internshipUid, application, applicantUid)
        .then((value) {
      ref
          .read(localUserProvider.notifier)
          .addInternshipApplication(internshipUid);

      ScaffoldMessenger.of(context)
          .showSnackBar(
            const SnackBar(
              content: Text("Succesfuly Applied"),
              backgroundColor: Color.fromRGBO(237, 92, 90, 1),
            ),
          )
          .closed
          .then((value) => Navigator.pop(context));
    });
  }
}
