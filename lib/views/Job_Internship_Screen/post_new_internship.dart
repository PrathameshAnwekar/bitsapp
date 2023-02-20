import 'package:bitsapp/controllers/internship_data_controller.dart';
import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/services/logger_service.dart';
import 'package:bitsapp/views/components/person_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFF7F6F8),
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
          Container(
            width: 72,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF4D5470),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            child: const Text("Post",
                style: TextStyle(fontSize: 18, color: Colors.white)),
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
                      CircleProfilePic(radius: 16),
                      Spacer(flex: 1),
                      PersonDetail(user: localUser),
                      Spacer(flex: 15),
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
                  Row(
                    children: [
                      const Title1(txt: "Skill(s) required: "),
                      Expanded(
                        child: TextFormField(
                          controller: skillController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter atleast one skill';
                            }
                            return null;
                          },
                          cursorColor: Colors.black54,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                bottom: -10.0, left: 10, right: 10),
                            hintText: 'Separate skills using commas',
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
      ),
    );
  }
}
