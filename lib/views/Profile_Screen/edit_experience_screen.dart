import 'package:bitsapp/constants/constants.dart';
import 'package:bitsapp/services/logger_service.dart';
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
            onPressed: () => showPopUp(context, isExperience),
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
                onEdit: (index) => showPopUp(
                  context,
                  isExperience,
                  oldData: userExperience[index],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showPopUp(BuildContext context, bool isExperience,
      {UserExperience? oldData}) {
    final bool isEdit = oldData != null;
    final String title2 = isExperience ? "Experience" : "Education";
    final String title1 = isEdit ? "Edit $title2" : "Add $title2";
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              actions: [
                ApplyNow(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: "Save",
                  elevation: 0,
                  alignment: MainAxisAlignment.spaceBetween,
                ),
              ],
              scrollable: true,
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              title: Text(title1),
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
                    initialValue: isEdit ? oldData.title : null,
                    // controller: titleController,
                    cursorColor: Colors.black54,
                    maxLength: 50,
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
                    initialValue: isEdit ? oldData.description : null,
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
                    children: [
                      DateWidget(
                        start: true,
                        oldDate: isEdit
                            ? DateTime.fromMillisecondsSinceEpoch(
                                oldData.start,
                              )
                            : DateTime(0, 0, 0),
                      ),
                      DateWidget(
                        start: false,
                        oldDate: isEdit
                            ? DateTime.fromMillisecondsSinceEpoch(
                                oldData.end,
                              )
                            : DateTime(0, 0, 0),
                      ),
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
  final DateTime oldDate;
  const DateWidget({
    super.key,
    required this.start,
    required this.oldDate,
  });

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Title1(txt: widget.start ? "Start Date" : "End Date"),
        GestureDetector(
          onTap: () async {
            final getDate = await pickDate(context, widget.oldDate);
            setState(() {
              dlog(getDate.toString());
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
                widget.oldDate != DateTime(0, 0, 0)
                    ? '${Constants.months[widget.oldDate.month - 1]} ${widget.oldDate.year}'
                    : widget.start
                        ? "${Constants.months[DateTime.now().month - 1]} ${DateTime.now().year}"
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

Future<DateTime?> pickDate(BuildContext context, DateTime oldDate) async {
  final initialDate = oldDate;
  final newDate = await showMonthYearPicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(DateTime.now().year - 50),
    lastDate: DateTime(DateTime.now().year + 1),
  );
  return newDate;
}
