import 'dart:io';

import 'package:bitsapp/controllers/auth_controller.dart';
import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/feed_post.dart';
import 'package:bitsapp/models/user_experience.dart';
import 'package:bitsapp/services/logger_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'components/profile_edit_info_stack.dart';
import 'components/vertical_menu.dart';
import 'edit_experience_screen.dart';

class ProfileScreen extends ConsumerWidget {
  final BitsUser? user;

  const ProfileScreen(this.user, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    BitsUser localUser = user ?? ref.watch(localUserProvider);
    bool isLocalUser = (user == null);
    var posts = localUser.feedPosts;

    List<UserExperience> temp = [
      UserExperience(
        title: 'Summer Intern',
        description: 'Jio Platforms Limited',
        start: 1654021800000,
        end: 1656613800000,
        type: ExperienceType.work,
      ),
      UserExperience(
        title: 'App Developer',
        description: 'Rentalz',
        start: 1643653800000,
        end: 1677609000000,
        type: ExperienceType.work,
      ),
      UserExperience(
        title: 'Summer Intern',
        description: 'CRISS Robotics',
        start: 1625077800000,
        end: 1643653800000,
        type: ExperienceType.work,
      ),
    ];
    List<UserExperience> temp2 = [
      UserExperience(
        title: 'Bits Pilani',
        description: 'Electronics and Instrumentation',
        start: 1577817000000,
        end: -62170003800000,
        type: ExperienceType.education,
      ),
      UserExperience(
        title: 'The Camford International School',
        description: '',
        start: 1514745000000,
        end: 1577817000000,
        type: ExperienceType.education,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: isLocalUser
            ? null
            : IconButton(
                icon: SizedBox(
                  height: 32,
                  width: 32,
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black.withOpacity(0.65),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
        actions: [
          Visibility(
            visible: isLocalUser,
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: SizedBox(
                height: 32,
                width: 32,
                child: IconButton(
                  icon: Icon(
                    Icons.logout,
                    color: Colors.black.withOpacity(0.65),
                  ),
                  onPressed: () {
                    AuthController.signOut(context, ref);
                  },
                ),
              ),
            ),
          ),
        ],
        scrolledUnderElevation: 0,
        title: Padding(
          padding: EdgeInsets.only(left: isLocalUser ? 3.5 : 0),
          child: Text(
            "Profile",
            style: GoogleFonts.roboto(
              color: Colors.black.withOpacity(0.65),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ProfileInfoStack(
                isLocalUser: isLocalUser,
                name: localUser.name,
                imageUrl: localUser.profilePicUrl,
                profileDescription: localUser.profileDescription,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 15),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Experience",
                          style: GoogleFonts.roboto(
                            color: Colors.black.withOpacity(0.65),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Visibility(
                          visible: isLocalUser,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.bottomToTop,
                                  child: ExperienceEditScreen(
                                    userExperience: temp,
                                    isExperience: true,
                                  ),
                                  childCurrent: this,
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
                      ],
                    ),
                    VerticalMenu(userExperience: temp, isEdit: false),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(vertical: 15),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Education",
                          style: GoogleFonts.roboto(
                            color: Colors.black.withOpacity(0.65),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Visibility(
                          visible: isLocalUser,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.bottomToTop,
                                  child: ExperienceEditScreen(
                                    userExperience: temp2,
                                    isExperience: false,
                                  ),
                                  childCurrent: this,
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
                      ],
                    ),
                    VerticalMenu(userExperience: temp2, isEdit: false),
                  ],
                ),
              ),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children:
                    List.generate(posts == null ? 0 : posts.length, (index) {
                  if (posts == null) posts = [];
                  return FutureBuilder(
                      future: FirebaseFirestore.instance
                          .doc("FeedPosts/${posts?[index]}")
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        final post = FeedPost.fromJson(snapshot.data!.data()!);
                        return FutureBuilder(
                            future: gridPostTile(post),
                            builder: (context, snapshot) {
                              return Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: snapshot.data ??
                                        const AssetImage("assets/applogo.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            });
                      });
                }),
              ),
              // Expanded(
              //   child: GridView.builder(
              //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 3,
              //         crossAxisSpacing: 10,
              //         mainAxisSpacing: 10,
              //         childAspectRatio: 1.0),
              //     itemCount: posts != null ? posts.length : 5,
              //     itemBuilder: (context, index) {
              //       elog(posts!.length.toString());
              //       return Container(
              //         // Your grid item widget
              //         width: 100,
              //         height: 200,
              //         color: Colors.green,
              //         child: Text('Grid Item $index'),
              //       );
              //       return FutureBuilder(
              //           future: FirebaseFirestore.instance
              //               .doc("FeedPosts/${posts![index]}")
              //               .get(),
              //           builder: (context, snapshot) {
              //             if (snapshot.connectionState ==
              //                 ConnectionState.waiting) {
              //               return const Center(
              //                 child: CircularProgressIndicator(),
              //               );
              //             }
              //             final post = FeedPost.fromJson(snapshot.data!.data()!);
              //             return GestureDetector(
              //               onTap: () {
              //                 // TODO: Show post details
              //               },
              //               child: post.mediaFilesList.isNotEmpty
              //                   ? Image.network(
              //                       post.mediaFilesList[0].url,
              //                       fit: BoxFit.cover,
              //                     )
              //                   : Container(
              //                       color: Colors.green,
              //                     ),
              //             );
              //           });
              //     },
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Future<ImageProvider<Object>> gridPostTile(FeedPost post) async {
    if (post.mediaFilesList.isNotEmpty) {
      if (post.mediaFilesList[0].type == 'image') {
        return NetworkImage(post.mediaFilesList[0].url);
      }
      if (post.mediaFilesList[0].type == 'video') {
        final fileName = await VideoThumbnail.thumbnailData(
          video: post.mediaFilesList[0].url,

          imageFormat: ImageFormat.WEBP,
          maxHeight:
              64, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
          quality: 50,
        );

        if (fileName != null) {
          return MemoryImage(fileName);
        }
      }
    }
    return const AssetImage("assets/applogo.png");
  }
}
