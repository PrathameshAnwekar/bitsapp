import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/services/firestore_feed_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/constants.dart';
import '../job_internship_screen/components/title1.dart';

class ProfileEditScreen extends HookConsumerWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localUser = ref.watch(localUserProvider);
    final descController =
        useTextEditingController(text: localUser.profileDescription ?? "");
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          "Edit Profile",
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
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Title1(txt: "Name"),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  isDense: true,
                ),
                enabled: false,
                style: GoogleFonts.dmSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromRGBO(27, 27, 27, 0.65),
                ),
                controller: TextEditingController()..text = localUser.name,
              ),
              const SizedBox(height: 10),
              const Title1(txt: "Headline"),
              TextFormField(
                controller: descController,

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
                  hintText:
                      "Exploring my options as a professional napper and Netflix connoisseur.",
                  hintStyle: GoogleFonts.firaSans(
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
                style: GoogleFonts.dmSans(
                  fontSize: 16,
                  color: const Color.fromRGBO(27, 27, 27, 1),
                ),
              ),
              const Title1(txt: "Add Links: "),
              const SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ...List.generate(
                    4,
                    (index) => GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(right: 14),
                        child: Icon(
                          Constants.socialIcons[index],
                          // color: Constants.socialIconColors[index],
                          color: index < 2
                              ? Constants.socialIconColors[index]
                              : const Color.fromRGBO(27, 27, 27, 0.3),
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          child: const Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          onPressed: () async {
            await FirestoreFeedService.setUserDescription(
                    descController.text, localUser.uid, ref)
                .then((value) {
              ref.read(localUserProvider).profileDescription =
                  descController.text;
              Navigator.of(context).pop();
            });
          }),
    );
  }
}
