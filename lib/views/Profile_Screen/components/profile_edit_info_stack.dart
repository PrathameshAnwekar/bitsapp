import 'dart:io';

import 'package:bitsapp/constants/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';

import '../../../services/logger_service.dart';
import '../profile_edit_screen.dart';
import 'profile_image_zoom.dart';

class ProfileInfoStack extends StatefulWidget {
  final String name;
  final String? imageUrl;
  final String? profileDescription;
  final bool isLocalUser;
  const ProfileInfoStack({
    super.key,
    required this.name,
    required this.isLocalUser,
    this.imageUrl,
    this.profileDescription,
  });

  @override
  State<ProfileInfoStack> createState() => _ProfileInfoStack();
}

class _ProfileInfoStack extends State<ProfileInfoStack> {
  File? fileMedia;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 70,
            bottom: 0,
            left: 0,
            right: 0,
            child: Card(
              shadowColor: Colors.grey.withOpacity(0.5),
              elevation: 6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                padding: const EdgeInsets.only(top: 80),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.65),
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      widget.profileDescription ??
                          "Your friendly neighbourhood bitsian",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.45),
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List.generate(
                          4,
                          (index) => GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 7),
                              child: Icon(
                                Constants.socialIcons[index],
                                color: Constants.socialIconColors[index],
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
          ),
          Visibility(
            visible: widget.isLocalUser,
            child: Positioned(
              right: 10,
              top: 72,
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.bottomToTop,
                      child: const ProfileEditScreen(),
                      childCurrent: widget,
                      duration: const Duration(milliseconds: 250),
                    ),
                  );
                },
                icon: const Icon(
                  FontAwesomeIcons.penToSquare,
                  size: 22,
                  color: Color(0xFF69708C),
                ),
              ),
            ),
          ),
          CircleAvatar(
            radius: 75,
            backgroundColor: const Color(0xFF69708C).withOpacity(0.2),
            child: GestureDetector(
              onTap: () => showPopUp(
                  "https://media.licdn.com/dms/image/D4D03AQGUfeCsI0M43A/profile-displayphoto-shrink_400_400/0/1680925107700?e=1686787200&v=beta&t=z2bRyfd5TA-jO3CIcmCwJ3IbbRey_mdyrC6gSeV316I",
                  context),
              child: fileMedia == null
                  ? CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.white,
                      backgroundImage: CachedNetworkImageProvider(
                          widget.imageUrl ??
                              "https://media.licdn.com/dms/image/D4D03AQGUfeCsI0M43A/profile-displayphoto-shrink_400_400/0/1680925107700?e=1686787200&v=beta&t=z2bRyfd5TA-jO3CIcmCwJ3IbbRey_mdyrC6gSeV316I",
                          errorListener: () {
                        elog("Error loading image");
                      }, cacheKey: "localUser.profilePicUrl"),
                    )
                  : CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.white,
                      backgroundImage: FileImage(fileMedia!),
                    ),
            ),
          ),
          Positioned(
            top: 95,
            right: 120,
            child: buildCircle(
              child: buildCircle(
                child: GestureDetector(
                  onTap: () => capture(),
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                color: const Color(0xFF69708C),
                padding: 8,
              ),
              color: Colors.white,
              padding: 3,
            ),
          ),
        ],
      ),
    );
  }

  Future capture() async {
    final getMedia = ImagePicker().pickImage;
    final media = await getMedia(source: ImageSource.gallery);
    final file = File(media!.path);
    setState(() {
      fileMedia = file;
    });
  }
}

Widget buildCircle({
  required Widget child,
  required Color color,
  required double padding,
}) =>
    ClipOval(
      child: Container(
        padding: EdgeInsets.all(padding),
        color: color,
        child: child,
      ),
    );
