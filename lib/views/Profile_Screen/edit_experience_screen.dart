import 'package:bitsapp/views/profile_screen/components/vertical_menu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../../models/user_experience.dart';
import '../job_internship_screen/components/apply_now.dart';
import '../job_internship_screen/components/title1.dart';

class ExperienceEditScreen extends StatelessWidget {
  const ExperienceEditScreen({
    super.key,
    required this.userExperience,
    required this.isExperience,
  });
  final List<UserExperience> userExperience;
  final bool isExperience;
  @override
  Widget build(BuildContext context) {
    final String title = isExperience ? "Experience" : "Education";
    final employmentType = [
      "Full-Time",
      "Part-Time",
      "Self-Employed",
      "Freelance",
      "Internship",
      "Trainee"
    ];
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          "Edit $title",
          style: GoogleFonts.inter(
            color: Colors.black.withOpacity(0.8),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.xmark,
            color: Colors.black.withOpacity(0.65),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: () => showPopUp(context, employmentType, isExperience),
            icon: Icon(
              FontAwesomeIcons.plus,
              color: Colors.black.withOpacity(0.65),
            ),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              VerticalMenu(
                userExperience: userExperience,
                isEdit: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  showPopUp(
      BuildContext context, List<String> employmentType, bool isExperience) {
    final String title = isExperience ? "Experience" : "Education";
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            String? selectedEmploymentType;
            return AlertDialog(
              actions: [
                ApplyNow(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: "Save",
                  elevation: 0,
                  alignment: MainAxisAlignment.spaceBetween,
                ),
                // SizedBox(
                //   height: 70,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       GestureDetector(
                //         onTap: () {
                //           Navigator.pop(context);
                //         },
                //         child: Container(
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(10),
                //             border: Border.all(
                //               color: Constants.kPrimaryColor,
                //             ),
                //           ),
                //           padding: const EdgeInsets.symmetric(
                //               horizontal: 35, vertical: 12),
                //           child: Text(
                //             "Back",
                //             style: GoogleFonts.roboto(
                //               color: Constants.kPrimaryColor,
                //               fontWeight: FontWeight.w500,
                //               fontSize: 17,
                //             ),
                //           ),
                //         ),
                //       ),
                //       GestureDetector(
                //         onTap: () {
                //           Navigator.pop(context);
                //         },
                //         child: Card(
                //           color: Constants.kPrimaryColor,
                //           shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(10)),
                //           shadowColor: Constants.kPrimaryColor.withOpacity(0.8),
                //           elevation: 6,
                //           child: Row(
                //             mainAxisSize: MainAxisSize.min,
                //             children: [
                //               Padding(
                //                 padding: const EdgeInsets.symmetric(
                //                   horizontal: 35,
                //                   vertical: 14,
                //                 ),
                //                 child: Text(
                //                   "Save",
                //                   style: GoogleFonts.roboto(
                //                     color: Colors.white,
                //                     fontWeight: FontWeight.w500,
                //                     fontSize: 16,
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
              scrollable: true,
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              title: Text("Add $title"),
              titleTextStyle: GoogleFonts.inter(
                color: Colors.black.withOpacity(0.8),
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              surfaceTintColor: Colors.white,
              titlePadding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
              contentPadding:
                  const EdgeInsets.only(left: 18, right: 18, bottom: 10),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width),
                  Title1(txt: isExperience ? "Title*" : "School*"),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid title';
                      }
                      return null;
                    },
                    // controller: titleController,
                    cursorColor: Colors.black54,
                    maxLength: 100,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.only(bottom: -10.0, left: 12),
                      hintText: 'Ex: App Developer',
                      hintStyle: GoogleFonts.firaSans(
                        fontSize: 16,
                        color: const Color.fromRGBO(0, 0, 0, 0.25),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(6),
                        ),
                        borderSide: BorderSide(color: Colors.grey.shade500),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(6),
                        ),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),

                    style: GoogleFonts.dmSans(
                      fontSize: 16,
                      color: const Color.fromRGBO(27, 27, 27, 1),
                    ),
                  ),
                  Title1(txt: isExperience ? "Company Name*" : "Degree"),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid company name';
                      }
                      return null;
                    },
                    // controller: titleController,
                    cursorColor: Colors.black54,
                    maxLength: 100,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.only(bottom: -10.0, left: 12),
                      hintText: 'Ex: Google India',
                      hintStyle: GoogleFonts.firaSans(
                        fontSize: 16,
                        color: const Color.fromRGBO(0, 0, 0, 0.25),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(6),
                        ),
                        borderSide: BorderSide(color: Colors.grey.shade500),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(6),
                        ),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    style: GoogleFonts.dmSans(
                      fontSize: 16,
                      color: const Color.fromRGBO(27, 27, 27, 1),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      DateWidget(start: true),
                      DateWidget(start: false),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class DateWidget extends StatefulWidget {
  final bool start;
  const DateWidget({
    super.key,
    required this.start,
  });

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  @override
  Widget build(BuildContext context) {
    DateTime? date = DateTime.now();
    List months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Title1(txt: widget.start ? "Start Date" : "End Date"),
        GestureDetector(
          onTap: () async {
            final getDate = await pickDate(context);
            setState(() {
              date = getDate;
            });
          },
          child: Container(
            height: 50,
            width: 150,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade500),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                widget.start
                    ? '${months[date.month - 1]} ${date.year}'
                    : "Present",
                style: GoogleFonts.roboto(
                  fontSize: 16.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Future<DateTime?> pickDate(BuildContext context) async {
  final initialDate = DateTime.now();
  final newDate = await showMonthYearPicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(DateTime.now().year - 50),
    lastDate: DateTime(DateTime.now().year + 1),
  );
  return newDate;
}
