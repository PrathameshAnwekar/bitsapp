import 'package:bitsapp/models/internship_application.dart';
import 'package:bitsapp/services/firestore_service.dart';
import 'package:bitsapp/services/logger_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'internship_data.g.dart';

final internshipDataProvider =
    StateNotifierProvider<InternshipDataNotifier, List<InternshipData>>(
        (ref) => InternshipDataNotifier());

@JsonSerializable()
class InternshipData {
  InternshipData({
    required this.uid,
    required this.title,
    required this.description,
    required this.applications,
    required this.posterUID,
    required this.time,
    required this.skills,
    required this.contactEmail,
    required this.compensation,
  });

  final String uid;
  final String title;
  final String description;
  final String posterUID;
  final int time;
  final List<String> skills;
  final String? contactEmail;
  final String compensation;
  List<InternshipApplication>? applications;

  factory InternshipData.fromJson(Map<String, dynamic> json) =>
      _$InternshipDataFromJson(json);

  /// Connect the generated [_$InternshipDataToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$InternshipDataToJson(this);
}

class InternshipDataNotifier extends StateNotifier<List<InternshipData>> {
  //list of internships constructor
  InternshipDataNotifier() : super([]);


  void initInternshipsData(List<InternshipData> internshipData)  {
    state = internshipData;
  }

  //add internship to list
  Future<void> postInternship(InternshipData internshipData, String localUserUid) async {
    try {
      await FirestoreService.postInternship(internshipData, localUserUid);
      state = state..add(internshipData);
      dlog('Internship ${internshipData.title} added to list');
    } catch (e) {
      elog(e.toString());
    }
  }

  //update internship in list
  void updateInternship(InternshipData internshipData) async {
    try {
      await FirestoreService.updateInternship(internshipData);
      state = state.map((internship) {
        if (internship.uid == internshipData.uid) {
          internship = internshipData;
        }
        return internship;
      }).toList();
      dlog('Internship ${internshipData.title} updated in list');
    } catch (e) {
      elog(e.toString());
    }
  }

  //delete internship from list
  void deleteInternship(String internshipUid) async {
    try {
      await FirestoreService.deleteInternship(internshipUid);
      state =
          state.where((internship) => internship.uid != internshipUid).toList();
    } catch (e) {
      elog(e.toString());
    }
  }

  //add applicantion to internship
  Future<void> addApplication(
      String internshipUid, InternshipApplication application, String localUserUid) async {
    try{await FirestoreService.addInternshipApplication(internshipUid, application, localUserUid);
    state = state.map((internship) {
      if (internship.uid == internshipUid) {
        internship.applications!.add(application);
      }
      return internship;
    }).toList();}catch(e){
      elog(e.toString());
    }
  }

  Future<void> updateInternshipApplicationStatus(InternshipApplication application, InternshipData internship, String status)async{
    try{
      await FirestoreService.updateInternshipApplicationStatus(application, internship, status);
      state = state.map((internship) {
        if (internship.uid == internship.uid) {
          internship.applications!.map((application) {
            if (application.uid == application.uid) {
              application.status = status;
            }
            return application;
          }).toList();
        }
        return internship;
      }).toList();
    }catch(e){
      elog(e.toString());
    }
  }
}
