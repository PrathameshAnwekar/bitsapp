import 'package:bitsapp/controllers/auth_controller.dart';
import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/user_experience.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_transition/page_transition.dart';

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
    List<UserExperience> temp = [
      UserExperience(
        title: 'Summer Intern',
        description: 'Jio Platforms Limited',
        start: 1,
        end: 2,
        type: ExperienceType.work,
      ),
      UserExperience(
        title: 'App Developer',
        description: 'Rentalz',
        start: 1,
        end: 2,
        type: ExperienceType.work,
      ),
      UserExperience(
        title: 'Summer Intern',
        description: 'CRISS Robotics',
        start: 1,
        end: 2,
        type: ExperienceType.work,
      ),
    ];
    List<UserExperience> temp2 = [
      UserExperience(
        title: 'Bits Pilani',
        description: 'Electronics and Instrumentation',
        start: 1,
        end: 2,
        type: ExperienceType.education,
      ),
      UserExperience(
        title: 'The Camford International School',
        description: '',
        start: 1,
        end: 2,
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
            style: TextStyle(
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
                    // const ExperienceWidget(
                    //   url:
                    //       "https://jep-asset.akamaized.net/jio/svg-og/jio_logo.png",
                    //   txt1: "Summer Intern",
                    //   txt2: "Jio Platforms Limited · Internship",
                    //   txt3: "Jun 2022 - Jul 2022 · 2 mos",
                    //   showEdit: false,
                    // ),
                    // const ExperienceWidget(
                    //   url:
                    //       "https://media.licdn.com/dms/image/C4D0BAQF4FNXeLIGIaA/company-logo_100_100/0/1628696386405?e=1684972800&v=beta&t=gxswQ2V7FRmjIZwRAp129CzoW4_xWlhxXWI2bUY_R3Q",
                    //   txt1: "App Developer",
                    //   txt2: "Rentalz · Part-time",
                    //   txt3: "Sep 2021 - Feb 2022 · 6 mos",
                    //   showEdit: false,
                    // ),
                    // const ExperienceWidget(
                    //   url:
                    //       "https://media.licdn.com/dms/image/C4E0BAQGJ6Z9crpkcXw/company-logo_100_100/0/1629550065724?e=1684972800&v=beta&t=KKLx6qZHKGmK1n2YingHh-WdO-x6jHif5hzfSSWsWok",
                    //   txt1: "Summer Intern",
                    //   txt2: "CRISS Robotics · Internship",
                    //   txt3: "Jul 2021 - Feb 2022 · 8 mos",
                    //   showEdit: false,
                    // ),
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
                    // const ExperienceWidget(
                    //   url:
                    //       "https://media.licdn.com/dms/image/C510BAQFYyp6NIc6n2A/company-logo_100_100/0/1539083994824?e=1684972800&v=beta&t=XdAP4lWl6r1I2NMtcvmoJBoCAJ9IGgpQjUYF5fEdG5w",
                    //   txt1: "Bits Pilani",
                    //   txt2: "Electronics and Instrumentation",
                    //   txt3: "2022 - 2024",
                    //   showEdit: false,
                    // ),
                    // const ExperienceWidget(
                    //   url:
                    //       "https://imgs.search.brave.com/YXw_8nP0SsLihynYGUbasNPbeLL4szRrTqjONaMmYq8/rs:fit:225:225:1/g:ce/aHR0cHM6Ly90c2Uy/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC5Z/YWcwLUNCN2ktZG5s/aFlFRlh2U0dnQUFB/QSZwaWQ9QXBp",
                    //   txt1: "The Camford International School",
                    //   txt2: "2018-2020",
                    //   txt3: "",
                    //   showEdit: false,
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
