import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/internship_data.dart';
import 'package:bitsapp/views/Components/person_detail.dart';
import 'package:bitsapp/views/components/circle_profile_pic.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:readmore/readmore.dart';

import '../job_detail_screen.dart';
import 'tags.dart';

class InternshipsListView extends HookConsumerWidget {
  const InternshipsListView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactsList = ref.watch(contactsListProvider);
    final internData = ref.watch(internshipDataProvider);
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        final poster = contactsList.firstWhere(
            (element) => element.uid == internData[index].posterUID);
        return InternshipCard(
          internshipData: internData[index],
          poster: poster,
        );
      },
      itemCount: internData.length,
    );
  }
}

class InternshipCard extends StatelessWidget {
  const InternshipCard({
    super.key,
    required this.internshipData,
    required this.poster,
  });
  final InternshipData internshipData;
  final BitsUser poster;

  List<Tags> skillTagBuilder() {
    final List<Tags> skillTags = [];
    for (int i = 0; i < internshipData.skills.length; i++) {
      skillTags.add(
        Tags(
          text: internshipData.skills[i],
          inPadding: 5,
          borderRadius: 10,
          textSize: 13,
        ),
      );
    }
    return skillTags;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: ((context) => JobDetailScreen(
                internshipData: internshipData,
                poster: poster,
              )),
        ),
      ),
      child: Container(
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
                const CircleProfilePic(radius: 16),
                const Spacer(flex: 1),
                PersonDetail(user: poster),
                const Spacer(flex: 15),
                Tags(
                  text: internshipData.compensation,
                  inPadding: 4,
                  borderRadius: 15,
                  textSize: 13,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              internshipData.title,
              style: GoogleFonts.dmSans(
                color: Colors.black.withOpacity(0.7),
                fontWeight: FontWeight.w300,
                // color: const Color.fromRGBO(248, 248, 253, 1),
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 12),
            ReadMoreText(
              internshipData.description,
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
              children: skillTagBuilder(),
            ),
          ],
        ),
      ),
    );
  }
}
