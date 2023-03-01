import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/internship_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:readmore/readmore.dart';

import '../../../../constants/constants.dart';
import '../../../components/circle_profile_pic.dart';
import '../../../components/person_detail.dart';
import '../../Components/application_status.dart';
import '../../components/tags.dart';

class AppliedInternships extends HookConsumerWidget {
  const AppliedInternships({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactsList = ref.watch(contactsListProvider);
    final localUser = ref.watch(localUserProvider);
    final internData = ref.watch(internshipDataProvider);
    final applicationUids = localUser.appliedInternships ?? [];

    final applicationsList = applicationUids
        .map(
          (e) => internData.firstWhere(
            (element) => element.uid == e,
          ),
        )
        .toList();
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        final internData = applicationsList[index];
        final applicationData = internData.applications!
            .where((element) => element.uid == localUser.uid)
            .first;
        return GestureDetector(
          child: Container(
            // height: 140,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xFFdfdee8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleProfilePic(radius: 16),
                    Spacer(flex: 1),
                    PersonDetail(
                      user: contactsList.firstWhere(
                          (element) => element.uid == internData.posterUID),
                    ),
                    Spacer(flex: 15),
                    Tags(
                      text: internData.compensation,
                      inPadding: 4,
                      borderRadius: 15,
                      textSize: 13,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  internData.title,
                  style: GoogleFonts.dmSans(
                    color: Colors.black.withOpacity(0.7),
                    fontWeight: FontWeight.w300,
                    // color: const Color.fromRGBO(248, 248, 253, 1),
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 12),
                ReadMoreText(
                  internData.description,
                  textAlign: TextAlign.start,
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimExpandedText: ' show less',
                  trimCollapsedText: ' ',
                  style: GoogleFonts.dmSans(
                    color: const Color(0xFF383D51),
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                    alignment: WrapAlignment.start,
                    direction: Axis.horizontal,
                    runSpacing: 6,
                    spacing: 10,
                    children: _tagBuilder(internData.skills)),
                const Divider(
                  height: 22,
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Yet to be done feature time",
                      style: const TextStyle(fontSize: 14),
                    ),
                    ApplicationStatus(
                      text: applicationData.status,
                      color: Constants.statusList[applicationData.status],
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
      itemCount: applicationsList.length,
    );
  }

  List<Tags> _tagBuilder(List<String> tags) {
    final List<Tags> tagList = [];
    for (final tag in tags) {
      tagList.add(
        Tags(
          text: tag,
          inPadding: 5,
          borderRadius: 10,
          textSize: 13,
        ),
      );
    }
    return tagList;
  }
}
