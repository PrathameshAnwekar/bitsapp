import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

import 'job_detail_screen copy.dart';

class JobInternhipScreen extends StatelessWidget {
  const JobInternhipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F6F8),
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            "Hello Prathamesh",
            style: GoogleFonts.dmSans(
              color: Colors.black.withOpacity(0.7),
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF7F6F8),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 15),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: _searchbar(),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 118, 84, 1),
                        borderRadius: BorderRadius.circular(15)),
                    height: 65,
                    width: 60,
                    child: SvgPicture.asset(
                      'assets/icons/vertical_filter.svg',
                      color: const Color.fromRGBO(248, 251, 254, 0.95),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: _listView()),
          ],
        ),
      ),
    );
  }
}

Widget _searchbar() {
  return TextFormField(
    style: GoogleFonts.manrope(
      color: Colors.white.withOpacity(0.9),
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    // focusNode: focusNode,
    textCapitalization: TextCapitalization.none,
    textInputAction: TextInputAction.done,
    keyboardType: TextInputType.multiline,
    maxLines: null,
    cursorColor: Colors.grey,
    cursorRadius: const Radius.elliptical(2, 2),
    cursorWidth: 2,
    decoration: InputDecoration(
      contentPadding:
          const EdgeInsets.only(top: 21, left: 26, right: 12, bottom: 21),
      hintText: 'What are you looking for?',
      hintStyle: GoogleFonts.dmSans(
        fontSize: 17,
        color: Colors.white70,
      ),
      filled: true,
      // fillColor: const Color.fromRGBO(48, 48, 48, 1),
      fillColor: const Color.fromRGBO(49, 50, 54, 1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
    ),
  );
}

Widget _listView() {
  return ListView.separated(
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    itemBuilder: (BuildContext context, int index) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) => const JobDetailScreen(
                  // circlecolor: const Color.fromRGBO(204, 240, 191, 1),
                  // logoUrl: 'assets/icons/freelance.svg',
                  // index: index,
                  )),
            ),
          );
        },
        child: Container(
          // height: 140,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xFFdfdee8).withOpacity(0.8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: const Color.fromRGBO(226, 210, 254, 1),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: SvgPicture.asset(
                        'assets/icons/freelance.svg',
                        fit: BoxFit.cover,
                        color: const Color.fromRGBO(54, 50, 60, 1),
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Kaushal Kirpekar',
                        style: GoogleFonts.dmSans(
                          // color: Colors.white.withOpacity(0.9),
                          color: const Color(0xFF383D51),
                          // fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '1d ago',
                        style: GoogleFonts.dmSans(
                          color: const Color(0xFF383D51),
                          letterSpacing: 0.2,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(
                    flex: 15,
                  ),
                  _tags("Paid", 4, 15, 13),
                  const SizedBox(width: 10),
                  _tags("Equity", 4, 15, 13),
                  // _tags("Revenue Split", 2, 15, 10)
                ],
              ),
              const SizedBox(height: 12),
              Text(
                "Social media manager",
                style: GoogleFonts.dmSans(
                  color: Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.w300,
                  // color: const Color.fromRGBO(248, 248, 253, 1),
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 12),
              ReadMoreText(
                "Planning and develpoing social media campaigns. Crafitng compelling content or getting it developed. Posting content across scocial media",
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
                children: <Widget>[
                  // ListView.separated(
                  //   shrinkWrap: true,
                  //   itemBuilder: (BuildContext context, int index) {
                  //     return _tags("Python");
                  //   },
                  //   separatorBuilder: (BuildContext context, int index) {
                  //     return const SizedBox(
                  //       width: 10,
                  //     );
                  //   },
                  //   itemCount: 5,
                  // ),
                  _tags("Python", 5, 10, 13),
                  _tags("Machine Learning", 5, 10, 13),
                  _tags("Dsa", 5, 10, 13),
                  // const Spacer(),
                  // Container(
                  //   padding:
                  //       const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(25),
                  //     color:
                  //         // const Color.fromRGBO(236, 201, 166, 1),
                  //         // const Color.fromRGBO(114, 110, 245, 1),
                  //         const Color.fromRGBO(11, 172, 184, 1),
                  //   ),
                  //   child: Text(
                  //     'Apply',
                  //     style: GoogleFonts.dmSans(
                  //       color:
                  //           // const Color.fromRGBO(54, 50, 60, 1),\
                  //           Colors.white.withOpacity(0.98),
                  //       fontSize: 15,
                  //     ),
                  //   ),
                  // )
                ],
              )
            ],
          ),
        ),
      );
    },
    separatorBuilder: (BuildContext context, int index) {
      return const SizedBox(
        height: 20,
      );
    },
    itemCount: 5,
  );
}

Widget _tags(
    String text, double inPadding, double borderRadius, double textSize) {
  return Container(
    padding: EdgeInsets.all(inPadding),
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.black.withOpacity(0.7),
      ),
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    child: Text(
      text,
      style: GoogleFonts.dmSans(
        color: Colors.black.withOpacity(0.7),
        fontSize: textSize,
      ),
    ),
  );
}
