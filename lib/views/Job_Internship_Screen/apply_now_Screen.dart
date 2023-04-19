import 'package:auto_size_text/auto_size_text.dart';
import 'package:bitsapp/constants/constants.dart';
import 'package:bitsapp/controllers/internship_data_controller.dart';
import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/internship_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ApplyNowScreen extends HookConsumerWidget {
  ApplyNowScreen({super.key, required this.internshipUid});
  final String internshipUid;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localUser = ref.watch(localUserProvider);
    final coverLetterController = useTextEditingController();
    final internshipData = ref
        .watch(internshipDataProvider)
        .where((element) => element.uid == internshipUid)
        .first;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 20,
        backgroundColor: Colors.white,
        title: AutoSizeText(
          internshipData.title,
          style: GoogleFonts.roboto(
            color: Colors.black.withOpacity(0.7),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 2,
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: _bottomWidget(context, _formKey,
          coverLetterController, ref, localUser, internshipUid),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _heading1("Your resume", 20, 10),
                Container(
                  height: 250,
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    // color: const Color(0xFFdfdee8).withOpacity(0.8),
                    color: Constants.kSecondaryColor,
                  ),
                ),
                _heading1("Contact details", 25, 5),
                _heading2("Phone Number: ", "999999999"),
                _heading2("Email Id: ", localUser.email),
                _heading1("Cover letter", 25, 5),
                TextFormField(
                  controller: coverLetterController,
                  // focusNode: _descFocus,
                  cursorColor: const Color(0xFF383D51).withOpacity(0.8),
                  // controller: desccontroller,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  minLines: 6,
                  maxLines: 7,
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    color: const Color.fromRGBO(27, 27, 27, 1),
                  ),
                  maxLength: 400,
                  // onFieldSubmitted: (_) {
                  //   _fieldFocusChange(
                  //       context, _descFocus, _priceFocus);
                  // },
                  // onSaved: (value) {
                  //   _editeditem = Item(
                  //     title: _editeditem.title,
                  //     description: value!,
                  //     price: _editeditem.price,
                  //     category: _editeditem.category,
                  //     profileId: _editeditem.profileId,
                  //     imageList: _editeditem.imageList,
                  //     id: _editeditem.id,
                  //   );
                  // },
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Description cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.only(top: 20, left: 12, right: 12),
                    hintText:
                        'Mention what relevant skill or past experience you have for this internship',
                    hintStyle: GoogleFonts.roboto(
                      fontSize: 16,
                      color: const Color.fromRGBO(0, 0, 0, 0.25),
                    ),
                    filled: true,
                    // fillColor: const Color.fromRGBO(242, 242, 242, 1),
                    fillColor: Constants.kSecondaryColor,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _heading1(String txt, double top, double bottom) {
  return Padding(
    padding: EdgeInsets.only(
      top: top,
      bottom: bottom,
    ),
    child: Text(
      txt,
      style: GoogleFonts.roboto(
        color: const Color(0xFF4D5470),
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
    ),
  );
}

Widget _heading2(String txt, String txt2) {
  return Padding(
    padding: const EdgeInsets.only(top: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          txt,
          style: GoogleFonts.roboto(
            color: const Color(0xFF4D5470),
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        Text(
          txt2,
          style: GoogleFonts.roboto(
            color: Colors.black.withOpacity(0.7),
            fontSize: 14,
          ),
        ),
      ],
    ),
  );
}

Widget _bottomWidget(BuildContext context, formKey, coverLetterController, ref,
    localUser, internshipUid) {
  return Material(
    elevation: 14,
    color: Colors.white,
    child: SizedBox(
      height: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  // color: const Color(0xFF149fda),
                  color: Constants.kPrimaryColor,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
              child: Text(
                "Back",
                style: GoogleFonts.roboto(
                  color: Constants.kPrimaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (formKey.currentState!.validate()) {
                InternshipDataController.addApplication(
                  ref: ref,
                  applicantUid: localUser.uid,
                  internshipUid: internshipUid,
                  coverLetter: coverLetterController.text,
                  context: context,
                );
              }
            },
            child: Card(
              color: Constants.kPrimaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              shadowColor: const Color(0xFF149fda).withOpacity(0.6),
              elevation: 6,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 14),
                child: Text(
                  "Submit",
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
