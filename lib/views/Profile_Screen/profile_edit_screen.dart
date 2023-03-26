import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/recieved_notification.dart';
import 'package:bitsapp/services/notif_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../profile_screen/components/data_widget.dart';
import 'components/profile_edit_info_stack.dart';
import 'components/profile_info_stack.dart';

class ProfileEditScreen extends ConsumerWidget {
  final BitsUser? user;

  const ProfileEditScreen(this.user, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final BitsUser localUser = user ?? ref.watch(localUserProvider);
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 12, bottom: 100),
        child: FloatingActionButton(
          heroTag: "profile",
          onPressed: () {
            NotifService.showLocalNotification(ReceivedNotification(
                id: 1,
                title: "Hello",
                body: "This is a notification",
                payload: "This is a payload"));
          },
          child: const Icon(Icons.add),
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              FontAwesomeIcons.check,
              size: 26,
              color: Colors.green,
            ),
          )
        ],
        scrolledUnderElevation: 0,
        title: Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.black.withOpacity(0.65),
            fontWeight: FontWeight.w500,
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
              ProfileEditInfoStack(
                name: localUser.name,
                imageUrl: localUser.profilePicUrl,
                profileDescription: localUser.profileDescription,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.17),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Experience",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.65),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const ExperienceWidget(
                      url:
                          "https://jep-asset.akamaized.net/jio/svg-og/jio_logo.png",
                      txt1: "Summer Intern",
                      txt2: "Jio Platforms Limited (JPL) · Internship",
                      txt3: "Jun 2022 - Jul 2022 · 2 mos",
                    ),
                    const ExperienceWidget(
                      url:
                          "https://media.licdn.com/dms/image/C4D0BAQF4FNXeLIGIaA/company-logo_100_100/0/1628696386405?e=1684972800&v=beta&t=gxswQ2V7FRmjIZwRAp129CzoW4_xWlhxXWI2bUY_R3Q",
                      txt1: "App Developer",
                      txt2: "Rentalz · Part-time",
                      txt3: "Sep 2021 - Feb 2022 · 6 mos",
                    ),
                    const ExperienceWidget(
                      url:
                          "https://media.licdn.com/dms/image/C4E0BAQGJ6Z9crpkcXw/company-logo_100_100/0/1629550065724?e=1684972800&v=beta&t=KKLx6qZHKGmK1n2YingHh-WdO-x6jHif5hzfSSWsWok",
                      txt1: "Summer Intern",
                      txt2: "CRISS Robotics · Internship",
                      txt3: "Jul 2021 - Feb 2022 · 8 mos",
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.17),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Education",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.65),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const ExperienceWidget(
                      url:
                          "https://media.licdn.com/dms/image/C510BAQFYyp6NIc6n2A/company-logo_100_100/0/1539083994824?e=1684972800&v=beta&t=XdAP4lWl6r1I2NMtcvmoJBoCAJ9IGgpQjUYF5fEdG5w",
                      txt1: "Bits Pilani",
                      txt2: "Electronics and Instrumentation",
                      txt3: "2022 - 2024",
                    ),
                    const ExperienceWidget(
                      url:
                          "https://imgs.search.brave.com/YXw_8nP0SsLihynYGUbasNPbeLL4szRrTqjONaMmYq8/rs:fit:225:225:1/g:ce/aHR0cHM6Ly90c2Uy/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC5Z/YWcwLUNCN2ktZG5s/aFlFRlh2U0dnQUFB/QSZwaWQ9QXBp",
                      txt1: "The Camford International School",
                      txt2: "2018-2020",
                      txt3: "",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 75),
            ],
          ),
        ),
      ),
    );
  }
}
