import 'package:bitsapp/views/profile_screen/components/divider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../job_internship_screen/components/title1.dart';
import 'components/data_widget.dart';

class ExperienceEditScreen extends StatelessWidget {
  const ExperienceEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          "Edit Experience",
          style: GoogleFonts.dmSans(
            color: Colors.black.withOpacity(0.65),
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
            onPressed: () => showPopUp(context, employmentType),
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
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const ExperienceWidget(
                url: "https://jep-asset.akamaized.net/jio/svg-og/jio_logo.png",
                txt1: "Summer Intern",
                txt2: "Jio Platforms Limited · Internship",
                txt3: "Jun 2022 - Jul 2022 · 2 mos",
                showEdit: true,
              ),
              div(),
              const ExperienceWidget(
                url:
                    "https://media.licdn.com/dms/image/C4D0BAQF4FNXeLIGIaA/company-logo_100_100/0/1628696386405?e=1684972800&v=beta&t=gxswQ2V7FRmjIZwRAp129CzoW4_xWlhxXWI2bUY_R3Q",
                txt1: "App Developer",
                txt2: "Rentalz · Part-time",
                txt3: "Sep 2021 - Feb 2022 · 6 mos",
                showEdit: true,
              ),
              div(),
              const ExperienceWidget(
                url:
                    "https://media.licdn.com/dms/image/C4E0BAQGJ6Z9crpkcXw/company-logo_100_100/0/1629550065724?e=1684972800&v=beta&t=KKLx6qZHKGmK1n2YingHh-WdO-x6jHif5hzfSSWsWok",
                txt1: "Summer Intern",
                txt2: "CRISS Robotics · Internship",
                txt3: "Jul 2021 - Feb 2022 · 8 mos",
                showEdit: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: GoogleFonts.dmSans(fontSize: 20),
        ),
      );
  showPopUp(BuildContext context, List<String> employmentType) => showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              String? selectedEmploymentType;
              return AlertDialog(
                actions: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF4D5470),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 6),
                      child: const Text("Save",
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  )
                ],
                scrollable: true,
                insetPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                title: const Text("Add experience"),
                titleTextStyle: GoogleFonts.dmSans(
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
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
                    const Title1(txt: "Title"),
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
                    const Title1(txt: "Company Name"),
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
                    const Title1(txt: "Employment Type"),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade500),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: const Text("Please Select"),
                          value: selectedEmploymentType,
                          isExpanded: true,
                          items: employmentType.map(buildMenuItem).toList(),
                          onChanged: (value) => setState(() {
                            selectedEmploymentType = value;
                          }),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
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
                '${months[date.month - 1]} ${date.year}',
                style: GoogleFonts.dmSans(fontSize: 17),
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
    firstDate: DateTime(DateTime.now().year - 30),
    lastDate: DateTime(DateTime.now().year + 1),
  );
  return newDate;
}
