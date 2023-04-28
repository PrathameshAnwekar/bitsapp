import 'package:bitsapp/views/chat/chats_screen.dart';
import 'package:bitsapp/views/new_post_screen/new_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/constants.dart';
import '../feed_screen/feed_screen.dart';
import '../job_internship_screen/job_internship_screen.dart';
import '../profile_screen/profile_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  static const routeName = '/bottom-nav-screen';
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _pageindex = 3;
  List<Widget> pagelist = <Widget>[
    FeedScreen(),
    const JobInternhipScreen(),
    NewPostScreen(),
    const ChatsScreen(),
    const ProfileScreen(null),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: false,
      body: IndexedStack(
        index: _pageindex,
        children: pagelist,
      ),
      bottomNavigationBar: SizedBox(
        height: 68,
        child: BottomNavigationBar(
          currentIndex: _pageindex,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          elevation: 4,
          onTap: (value) {
            setState(() {
              _pageindex = value;
            });
          },
          backgroundColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/home_outline.svg',
                width: 27,
                height: 27,
                color: Constants.inactiveIconColor,
              ),
              label: "Home",
              activeIcon: SvgPicture.asset(
                'assets/icons/home_filled.svg',
                width: 28,
                height: 28,
                color: Constants.kPrimaryColor,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/internship_outline.svg',
                width: 27,
                height: 27,
                color: Constants.inactiveIconColor,
              ),
              label: "Jobs",
              activeIcon: SvgPicture.asset(
                'assets/icons/internship_filled.svg',
                width: 29,
                height: 29,
                color: Constants.kPrimaryColor,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/newPost_outline.svg',
                width: 27,
                height: 27,
                color: Constants.inactiveIconColor,
              ),
              label: "Post",
              activeIcon: SvgPicture.asset(
                'assets/icons/newPost_filled.svg',
                width: 30.5,
                height: 30.5,
                color: Constants.kPrimaryColor,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/chat_outline.svg',
                width: 27,
                height: 27,
                color: Constants.inactiveIconColor,
              ),
              label: "Chat",
              activeIcon: SvgPicture.asset(
                'assets/icons/chat_filled.svg',
                width: 30.5,
                height: 30.5,
                color: Constants.kPrimaryColor,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/user_outline.svg',
                width: 27,
                height: 27,
                color: Constants.inactiveIconColor,
              ),
              label: "Profile",
              activeIcon: SvgPicture.asset(
                'assets/icons/user_filled.svg',
                width: 29,
                height: 29,
                color: Constants.kPrimaryColor,
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: SafeArea(
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 25),
      //     child: BlurryContainer(
      //       height: 64,
      //       blur: 4.5,
      //       color: const Color.fromRGBO(49, 50, 54, 1).withOpacity(0.75),
      //       borderRadius: const BorderRadius.all(Radius.circular(24)),
      //       padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           ...List.generate(
      //             pagelist.length,
      //             (index) => GestureDetector(
      //               onTap: () {
      //                 if (index != _pageindex) {
      //                   setState(() {
      //                     _pageindex = index;
      //                   });
      //                 }
      //               },
      //               child: Column(
      //                 children: [
      //                   AnimatedContainer(
      //                     duration: const Duration(milliseconds: 200),
      //                     margin: const EdgeInsets.only(bottom: 2),
      //                     height: 4,
      //                     width: index == _pageindex ? 25 : 0,
      //                     decoration: const BoxDecoration(
      //                       color: Color(0xFF81B4FF),
      //                       borderRadius: BorderRadius.all(Radius.circular(12)),
      //                     ),
      //                   ),
      //                   AnimatedContainer(
      //                     duration: const Duration(milliseconds: 200),
      //                     height: index == _pageindex ? 30 : 28,
      //                     width: index == _pageindex ? 34 : 32,
      //                     child: SvgPicture.asset(
      //                       Constants.bottomBarIcons[index],
      //                       color: index == _pageindex
      //                           ? Colors.white.withOpacity(0.8)
      //                           : Colors.white.withOpacity(0.35),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
