import 'package:bitsapp/controllers/internship_data_controller.dart';
import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/views/components/person_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

import '../../constants/constants.dart';
import '../components/circle_profile_pic.dart';
import 'components/title1.dart';

class PostNewInternship extends HookConsumerWidget {
  PostNewInternship({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localUser = ref.watch(localUserProvider);
    final descriptionController = useTextEditingController();
    final titleController = useTextEditingController();
    final compensationController = useTextEditingController();
    final contactEmailController = useTextEditingController();
    final skillController = useTextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leadingWidth: 40,
        centerTitle: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 6),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 26,
              color: Color(0xFF69708C),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            "Post an Internship",
            style: GoogleFonts.dmSans(
              color: const Color(0xFF4D5470),
              fontWeight: FontWeight.w400,
              fontSize: 21,
            ),
          ),
        ),
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                InternshipDataController.postNewInternship(ref, context,
                    title: titleController.text,
                    compensation: compensationController.text,
                    contactEmail: contactEmailController.text,
                    description: descriptionController.text,
                    posterUID: localUser.uid,
                    skills: skillController.text);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please fill all the fields'),
                  ),
                );
              }
            },
            child: Container(
              width: 72,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: const ShapeDecoration(
                color: Color(0xFF4D5470),
                shape: StadiumBorder(),
              ),
              padding: const EdgeInsets.fromLTRB(15, 4, 15, 8),
              child: const Text("Post",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      const CircleProfilePic(radius: 18),
                      const Spacer(flex: 1),
                      PersonDetail(user: localUser, isSmall: true),
                      const Spacer(flex: 15),
                    ],
                  ),
                  const Title1(txt: "Title"),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid title';
                      }
                      return null;
                    },
                    controller: titleController,
                    cursorColor: Colors.black54,
                    maxLength: 100,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.only(bottom: -10.0, left: 12),
                      hintText: 'Flutter app developer or Co-Founder',
                      hintStyle: GoogleFonts.firaSans(
                        // fontFamily: 'ManRope Regular',
                        fontSize: 16,
                        color: const Color.fromRGBO(0, 0, 0, 0.25),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(6),
                        ),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(6),
                        ),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    style: const TextStyle(
                      fontFamily: 'ManRope Regular',
                      fontSize: 16,
                      color: Color.fromRGBO(27, 27, 27, 1),
                    ),
                  ),
                  const Title1(txt: "Description"),
                  TextFormField(
                    controller: descriptionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid description';
                      }
                      return null;
                    },
                    cursorColor: Colors.black54,
                    maxLength: 400,
                    minLines: 5,
                    maxLines: 8,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(top: 20, left: 12),
                      hintText: 'Description of the role',
                      hintStyle: const TextStyle(
                        fontFamily: 'ManRope Regular',
                        fontSize: 16,
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(6),
                        ),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(6),
                        ),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    style: const TextStyle(
                      fontFamily: 'ManRope Regular',
                      fontSize: 16,
                      color: Color.fromRGBO(27, 27, 27, 1),
                    ),
                  ),
                  const SizedBox(height: 25),
                  MultiSelectDialogField(
                    backgroundColor: Colors.white,
                    buttonIcon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.black,
                    ),
                    buttonText: Text(
                      "Select Skill(s) required",
                      style: GoogleFonts.dmSans(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    dialogHeight: 500,
                    searchable: true,
                    title: const Title1(txt: "Skill(s) required: "),
                    items: Constants.skills
                        .map((e) => MultiSelectItem(e, e))
                        .toList(),
                    listType: MultiSelectListType.CHIP,
                    onConfirm: (values) {
                      // _selectedAnimals = values;
                    },
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Title1(txt: "Compensation type: "),
                      Expanded(
                        child: TextFormField(
                          controller: compensationController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid compensation type';
                            }
                            return null;
                          },
                          cursorColor: Colors.black54,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                bottom: -10.0, left: 10, right: 10),
                            hintText: 'Paid or Volunteer',
                            hintStyle: const TextStyle(
                              fontFamily: 'ManRope Regular',
                              fontSize: 16,
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(6),
                              ),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          style: const TextStyle(
                            fontFamily: 'ManRope Regular',
                            fontSize: 16,
                            color: Color.fromRGBO(27, 27, 27, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      const Title1(txt: "Contact email: "),
                      Expanded(
                        child: TextFormField(
                          controller: contactEmailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          cursorColor: Colors.black54,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                bottom: -10.0, left: 10, right: 10),
                            hintText: 'f20201556@samsung.org',
                            hintStyle: const TextStyle(
                              fontFamily: 'ManRope Regular',
                              fontSize: 16,
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(6),
                              ),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          style: const TextStyle(
                            fontFamily: 'ManRope Regular',
                            fontSize: 16,
                            color: Color.fromRGBO(27, 27, 27, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
