import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'job_detail_screen.dart';

class JobIntershipScreen extends StatefulWidget {
  const JobIntershipScreen({Key? key}) : super(key: key);

  @override
  State<JobIntershipScreen> createState() => _JobIntershipScreenState();
}

class _JobIntershipScreenState extends State<JobIntershipScreen> {
  final List<String> _recommendations = [
    'App Development',
    'Graphic Designer',
    'Web Developer',
    'BlockChain Developer'
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(25, 29, 30, 1),
      ),
      child: Scaffold(
        // backgroundColor: const Color.fromRGBO(16, 20, 23, 1),
        // backgroundColor: const Color.fromRGBO(33, 33, 33, 1),
        // backgroundColor: const Color.fromRGBO(25, 29, 32, 1),
        // backgroundColor: const Color.fromRGBO(32, 33, 37, 1),
        backgroundColor: const Color.fromRGBO(25, 29, 30, 1),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      "Hello Prathamesh",
                      style: GoogleFonts.quicksand(
                        color: const Color.fromRGBO(248, 251, 254, 1),
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Text(
                    "Find your perfect job",
                    style: GoogleFonts.dmSans(
                      color: const Color.fromRGBO(248, 251, 254, 1),
                      fontSize: 26,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 14),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: TextFormField(
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
                              contentPadding: const EdgeInsets.only(
                                  top: 21, left: 26, right: 12, bottom: 21),
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
                          ),
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
                  Container(
                    height: 43,
                    padding: const EdgeInsets.only(bottom: 10),
                    margin: const EdgeInsets.only(bottom: 20),
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              _recommendations[index],
                              style: GoogleFonts.dmSans(
                                color: const Color.fromRGBO(248, 251, 254, 0.9),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color.fromRGBO(248, 251, 254, 0.8),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(width: 10);
                        },
                        itemCount: _recommendations.length),
                  ),
                  SizedBox(
                    height: 220,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(186, 229, 244, 1),
                              borderRadius: BorderRadius.circular(17),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 28,
                                  backgroundColor: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: SvgPicture.asset(
                                      'assets/icons/freelance.svg',
                                      fit: BoxFit.cover,
                                      color:
                                          const Color.fromRGBO(54, 50, 60, 1),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                Text(
                                  '44.8k',
                                  style: GoogleFonts.lato(
                                    color: const Color.fromRGBO(54, 50, 60, 1),
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'For You',
                                  style: GoogleFonts.lato(
                                    color:
                                        const Color.fromRGBO(101, 123, 129, 1),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                height: 105,
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(226, 210, 254, 1),
                                  borderRadius: BorderRadius.circular(17),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 28,
                                      backgroundColor: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 8, 5, 5),
                                        child: SvgPicture.asset(
                                          'assets/icons/full_time.svg',
                                          fit: BoxFit.cover,
                                          color: const Color.fromRGBO(
                                              54, 50, 60, 1),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '66.8k',
                                          style: GoogleFonts.lato(
                                            color: const Color.fromRGBO(
                                                54, 50, 60, 1),
                                            fontWeight: FontWeight.w800,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          'Full Time',
                                          style: GoogleFonts.lato(
                                            color: const Color.fromRGBO(
                                                101, 123, 129, 1),
                                            // fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 105,
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(204, 240, 191, 1),
                                  borderRadius: BorderRadius.circular(17),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 28,
                                      backgroundColor: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: SvgPicture.asset(
                                          'assets/icons/part_time.svg',
                                          fit: BoxFit.cover,
                                          color: const Color.fromRGBO(
                                              54, 50, 60, 1),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '38.9k',
                                          style: GoogleFonts.lato(
                                            color: const Color.fromRGBO(
                                                54, 50, 60, 1),
                                            fontWeight: FontWeight.w800,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          'Part Time',
                                          style: GoogleFonts.lato(
                                            color: const Color.fromRGBO(
                                                101, 123, 129, 1),
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '  For You',
                          style: GoogleFonts.dmSans(
                            color: const Color.fromRGBO(248, 251, 254, 1),
                            fontSize: 23,
                          ),
                        ),
                        Text(
                          'See All',
                          style: GoogleFonts.dmSans(
                            color: const Color.fromRGBO(248, 251, 254, 0.8),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: ((context) => JobDetailScreen(
                                    circlecolor:
                                        const Color.fromRGBO(204, 240, 191, 1),
                                    logoUrl: 'assets/icons/freelance.svg',
                                    index: index,
                                  )),
                            ),
                          );
                        },
                        child: Container(
                          height: 160,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            // color: const Color.fromRGBO(49, 49, 49, 1),
                            // color: const Color.fromRGBO(49, 50, 54, 1),
                            color: const Color.fromRGBO(50, 51, 55, 1),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Hero(
                                    transitionOnUserGestures: true,
                                    tag: index,
                                    child: CircleAvatar(
                                      radius: 28,
                                      backgroundColor: const Color.fromRGBO(
                                          226, 210, 254, 1),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: SvgPicture.asset(
                                          'assets/icons/freelance.svg',
                                          fit: BoxFit.cover,
                                          color: const Color.fromRGBO(
                                              54, 50, 60, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Spacer(
                                    flex: 1,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Product Designer',
                                        style: GoogleFonts.dmSans(
                                          // color: Colors.white.withOpacity(0.9),
                                          color: const Color.fromRGBO(
                                              248, 248, 253, 1),
                                          // fontWeight: FontWeight.w600,
                                          fontSize: 21,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        '\$10K-\$12K/Monthly',
                                        style: GoogleFonts.dmSans(
                                          color: Colors.white70,
                                          letterSpacing: 0.2,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(
                                    flex: 3,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: SvgPicture.asset(
                                      'assets/icons/bookmark.svg',
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      'Full Time',
                                      style: GoogleFonts.dmSans(
                                        color: const Color.fromRGBO(
                                            248, 251, 254, 0.9),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color.fromRGBO(
                                            248, 251, 254, 0.8),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      'Senior Designer',
                                      style: GoogleFonts.dmSans(
                                        color: const Color.fromRGBO(
                                            248, 251, 254, 0.9),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color.fromRGBO(
                                            248, 251, 254, 0.8),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 5),
                                    child: Text(
                                      'Apply',
                                      style: GoogleFonts.dmSans(
                                        color:
                                            // const Color.fromRGBO(54, 50, 60, 1),\
                                            Colors.white.withOpacity(0.98),
                                        fontSize: 15,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color:
                                          // const Color.fromRGBO(236, 201, 166, 1),
                                          // const Color.fromRGBO(114, 110, 245, 1),
                                          const Color.fromRGBO(11, 172, 184, 1),
                                    ),
                                  )
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
                    itemCount: 4,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
