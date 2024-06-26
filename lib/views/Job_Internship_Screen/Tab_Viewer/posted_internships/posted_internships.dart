import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/internship_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:readmore/readmore.dart';

import 'posted_internships_details.dart';

class PostedInternships extends HookConsumerWidget {
  const PostedInternships({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localUser = ref.watch(localUserProvider);
    final internData = ref.watch(internshipDataProvider);
    final postedInternData = internData
        .where((element) => element.posterUID == localUser.uid)
        .toList();
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        final internship = postedInternData[index];
        return GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) =>
                  PostedInternshipDetails(internshipData: internship)),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xFFdfdee8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    internship.title,
                    style: GoogleFonts.dmSans(
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w300,
                      // color: const Color.fromRGBO(248, 248, 253, 1),
                      fontSize: 22,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: ReadMoreText(
                      internship.description,
                      textAlign: TextAlign.start,
                      trimLines: 5,
                      trimMode: TrimMode.Line,
                      trimExpandedText: ' show less',
                      trimCollapsedText: ' ',
                      style: GoogleFonts.dmSans(
                        color: const Color(0xFF383D51),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: postedInternData.length,
    );
  }
}
