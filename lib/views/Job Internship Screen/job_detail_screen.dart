import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class JobDetailScreen extends StatelessWidget {
  final Color circlecolor;
  final String logoUrl;
  final int index;
  const JobDetailScreen(
      {Key? key,
      required this.circlecolor,
      required this.logoUrl,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromRGBO(49, 49, 49, 1),

      backgroundColor: const Color.fromRGBO(49, 50, 54, 1),
      appBar: AppBar(
        // backgroundColor: const Color.fromRGBO(49, 49, 49, 1),
        backgroundColor: const Color.fromRGBO(49, 50, 54, 1),
        // systemOverlayStyle: const SystemUiOverlayStyle(
        //   statusBarColor: Color.fromRGBO(49, 50, 54, 1),
        // ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color.fromRGBO(49, 50, 54, 1),
        ),
        elevation: 0,
        title: Text(
          'Google',
          style: GoogleFonts.lato(
            color: const Color.fromRGBO(248, 248, 253, 1),
            fontSize: 20,
            // fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SvgPicture.asset(
              'assets/icons/bookmark.svg',
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  height: 200,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Container(
                        height: 200,
                        margin:
                            const EdgeInsets.only(left: 22, right: 22, top: 48),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromRGBO(25, 29, 30, 1),
                          // color: const Color.fromRGBO(32, 33, 37, 1),
                          // color: const Color.fromRGBO(23, 25, 24, 1),
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 60),
                              child: Text(
                                'UI/UX Designer',
                                style: GoogleFonts.dmSans(
                                  // color: Colors.white.withOpacity(0.9),
                                  color:
                                      const Color.fromRGBO(248, 248, 253, 0.86),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 23,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Google',
                                      style: GoogleFonts.dmSans(
                                        color: const Color.fromRGBO(
                                            248, 248, 253, 0.9),
                                        fontSize: 15,
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: VerticalDivider(
                                        color:
                                            Color.fromRGBO(248, 248, 253, 0.9),
                                        thickness: 1,
                                      ),
                                    ),
                                    Text(
                                      'California',
                                      style: GoogleFonts.dmSans(
                                        color: const Color.fromRGBO(
                                            248, 248, 253, 0.9),
                                        fontSize: 15,
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: VerticalDivider(
                                        color:
                                            Color.fromRGBO(248, 248, 253, 0.9),
                                        thickness: 1,
                                      ),
                                    ),
                                    Text(
                                      '1 day ago',
                                      style: GoogleFonts.dmSans(
                                        color: const Color.fromRGBO(
                                            248, 248, 253, 0.9),
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            transitionOnUserGestures: true,
                            tag: index,
                            child: CircleAvatar(
                              radius: 48,
                              backgroundColor: circlecolor,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: SvgPicture.asset(
                                  logoUrl,
                                  fit: BoxFit.cover,
                                  color: const Color.fromRGBO(54, 50, 60, 1),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const <Widget>[
                      DetailContainer(
                        circleColor: Color.fromRGBO(236, 201, 166, 1),
                        title: 'Salary',
                        desc: '\$40-64K',
                        logoURL: 'assets/icons/freelance.svg',
                      ),
                      DetailContainer(
                        circleColor: Color.fromRGBO(226, 210, 254, 1),
                        title: 'Job Type',
                        desc: 'Part time',
                        logoURL: 'assets/icons/freelance.svg',
                      ),
                      DetailContainer(
                        circleColor: Color.fromRGBO(186, 229, 244, 1),
                        title: 'Position',
                        desc: 'Junior',
                        logoURL: 'assets/icons/freelance.svg',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 22),
                  child: Text(
                    'Description',
                    style: GoogleFonts.dmSans(
                      color: const Color.fromRGBO(248, 248, 253, 0.9),
                      fontSize: 22,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DetailContainer extends StatelessWidget {
  final Color circleColor;
  final String title;
  final String desc;
  final String logoURL;
  const DetailContainer(
      {Key? key,
      required this.circleColor,
      required this.title,
      required this.desc,
      required this.logoURL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: circleColor,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: SvgPicture.asset(
              logoURL,
              fit: BoxFit.cover,
              color: const Color.fromRGBO(54, 50, 60, 1),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 4),
          child: Text(
            title,
            style: GoogleFonts.lato(
              color: const Color.fromRGBO(248, 248, 253, 0.75),
              // Colors.white,
              fontSize: 14,
              // fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          desc,
          style: GoogleFonts.lato(
            color: const Color.fromRGBO(248, 248, 253, 1),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
