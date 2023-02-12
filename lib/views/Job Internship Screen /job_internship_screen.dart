import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Tab Viewer/internship_tabview_screen.dart';
import 'components/internships_list_view.dart';
import 'components/search_bar.dart';
import 'post_new_internship.dart';

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
              fontSize: 21,
            ),
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: ((context) => const InternshipTabView()),
              ),
            ),
            icon: Icon(
              Icons.format_align_left_rounded,
              size: 28,
              color: Colors.black.withOpacity(0.7),
            ),
          )
        ],
      ),
      backgroundColor: const Color(0xFFF7F6F8),
      floatingActionButton: _floatingActionButton(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 15),
              child: Row(
                children: <Widget>[
                  const Flexible(
                    child: SearchBar(),
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
                      'assets/Icons/vertical_filter.svg',
                      color: const Color.fromRGBO(248, 251, 254, 0.95),
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(child: InternshipsListView()),
          ],
        ),
      ),
    );
  }
}

Widget _floatingActionButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(right: 15, bottom: 70),
    child: FloatingActionButton(
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: ((context) => const PostNewInternship()),
        ),
      ),
      backgroundColor: const Color.fromRGBO(49, 50, 54, 1),
      child: Icon(
        Icons.add_rounded,
        size: 40,
        color: Colors.white.withOpacity(0.9),
      ),
    ),
  );
}
