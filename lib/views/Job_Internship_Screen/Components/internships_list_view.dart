import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/internship_data.dart';
import 'package:bitsapp/services/logger_service.dart';
import 'package:bitsapp/views/Components/person_detail.dart';
import 'package:bitsapp/views/components/circle_profile_pic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:readmore/readmore.dart';
import 'package:simple_shadow/simple_shadow.dart';

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
      // separatorBuilder: (context, index) => const SizedBox(height: 20),
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
    elog("This is the 0th internship${internshipData.skills[0]}");
    final List<Tags> skillTags = [];
    for (int i = 0; i < internshipData.skills.length; i++) {
      skillTags.add(
        Tags(
          text: internshipData.skills[i],
          inPadding: 5,
          borderRadius: 12,
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
      child: SimpleShadow(
        sigma: 10,
        color: Colors.grey.withOpacity(0.8),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const CircleProfilePic(radius: 20),
                  const Spacer(flex: 1),
                  PersonDetail(
                      user: poster, isSmall: true, time: internshipData.time),
                  const Spacer(flex: 20),
                  SvgPicture.asset("assets/icons/add_bookmark.svg"),
                  SvgPicture.asset("assets/icons/remove_bookmark.svg"),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                internshipData.title,
                style: GoogleFonts.roboto(
                  color: Colors.black.withOpacity(0.8),
                  fontWeight: FontWeight.w700,
                  fontSize: 19.4,
                ),
              ),
              const SizedBox(height: 5),
              ReadMoreText(
                internshipData.description,
                textAlign: TextAlign.start,
                trimLines: 2,
                trimMode: TrimMode.Line,
                trimExpandedText: ' show less',
                trimCollapsedText: ' ',
                style: GoogleFonts.roboto(
                  fontSize: 13.5,
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 14),
              // Divider(
              //   endIndent: 3,
              //   indent: 3,
              //   height: 18,
              //   thickness: 0.5,
              //   color: Colors.grey.withOpacity(0.5),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 270,
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      direction: Axis.horizontal,
                      runSpacing: 6,
                      spacing: 10,
                      children: skillTagBuilder(),
                    ),
                  ),
                  SimpleShadow(
                    sigma: 5,
                    color: Colors.grey.shade400,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        internshipData.compensation,
                        style: GoogleFonts.roboto(
                          color: Colors.black.withOpacity(0.8),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
