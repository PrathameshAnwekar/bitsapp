
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
    required this.applicantUIDandCoverLetter,
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
  final String skills;
  final String? contactEmail;
  final String compensation;
  Map<String, String>? applicantUIDandCoverLetter;

  factory InternshipData.fromJson(Map<String, dynamic> json) =>
      _$InternshipDataFromJson(json);

  /// Connect the generated [_$InternshipDataToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$InternshipDataToJson(this);
}


class InternshipDataNotifier extends StateNotifier<List<InternshipData>>{
  //list of internships constructor
  InternshipDataNotifier() : super([]);


  //add internship to list
  void addInternship(InternshipData internshipData) async {
    state = state..add(internshipData);
    // await FirestoreService.addInternship(internshipData);
  }

  //update internship in list
  void updateInternship(String internshipUid, InternshipData internshipData) async {
    state = state.map((internship) {
      if (internship.uid == internshipUid) {
        internship = internshipData;
      }
      return internship;
    }).toList();
    // await FirestoreService.updateInternship(internshipUid, internshipData);
  }

  //delete internship from list
  void deleteInternship(String internshipUid) async {
    state = state.where((internship) => internship.uid != internshipUid).toList();
    // await FirestoreService.deleteInternship(internshipUid);
  }

  //add applicant to internship
  void addApplicant(String internshipUid, String applicantUid, String coverLetter) async {
    state = state.map((internship) {
      if (internship.uid == internshipUid) {
        internship.applicantUIDandCoverLetter = {...?internship.applicantUIDandCoverLetter, applicantUid: coverLetter};
      }
      return internship;
    }).toList();
    // await FirestoreService.addApplicant(internshipUid, applicantUid, coverLetter);
  }


}