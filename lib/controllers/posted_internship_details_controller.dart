import 'package:bitsapp/models/internship_application.dart';
import 'package:bitsapp/models/internship_data.dart';
import 'package:bitsapp/services/logger_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostedInternshipDetailsController {
  static Future<bool> updateInternshipApplicationStatus(
      WidgetRef ref,
      InternshipApplication application,
      InternshipData internship,
      String status) async {
    try {
      await ref
          .read(internshipDataProvider.notifier)
          .updateInternshipApplicationStatus(application, internship, status);
      return Future.value(true);
    } catch (e) {
      elog(e.toString());
      return Future.value(false);
    }
  }
}
