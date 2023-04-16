import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/views/chat/chats_screen.dart';
import 'package:bitsapp/views/new_post_screen/new_post_screen.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
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
  

  int _pageindex = 0;
  List<Widget> pagelist = <Widget>[
    FeedScreen(),
    const JobInternhipScreen(),
    NewPostScreen(),
    const ChatsScreen(),
    const ProfileScreen(null),
  ];
  @override
  Widget build(BuildContext context) {
    print("rebuilding bottom nav screen");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: IndexedStack(
        index: _pageindex,
        children: pagelist,
      ),
      // bottomNavigationBar: NavigationBar(
      //   height: 70,
      //   selectedIndex: _pageindex,
      //   onDestinationSelected: (value) {
      //     setState(() {
      //       _pageindex = value;
      //     });
      //   },
      //   labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      //   destinations: const [
      //     NavigationDestination(
      //       icon: Icon(Icons.home_outlined),
      //       selectedIcon: Icon(Icons.home_filled),
      //       label: "Home",
      //     ),
      //     NavigationDestination(
      //       icon: Icon(Icons.work_outline_rounded),
      //       selectedIcon: Icon(Icons.work_rounded),
      //       label: "Internships",
      //     ),
      //     NavigationDestination(
      //       icon: Icon(Icons.post_add_rounded),
      //       // selectedIcon: Icon(Icons.post_add),
      //       label: "New Post",
      //     ),
      //     NavigationDestination(
      //       icon: Icon(Icons.chat_bubble_outline),
      //       selectedIcon: Icon(Icons.chat_bubble_rounded),
      //       label: "Chat",
      //     ),
      //     NavigationDestination(
      //       icon: Icon(Icons.person_outline_rounded),
      //       selectedIcon: Icon(Icons.person_rounded),
      //       label: "Profile",
      //     ),
      //   ],
      // ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _pageindex,
      //   onTap: (value) {
      //     setState(() {
      //       _pageindex = value;
      //     });
      //   },
      //   selectedIconTheme:
      //       const IconThemeData(color: Color.fromRGBO(247, 154, 0, 1)),
      //   selectedItemColor: const Color.fromRGBO(247, 154, 0, 1),
      //   backgroundColor: Colors.white,
      //   showSelectedLabels: false,
      //   showUnselectedLabels: false,
      //   selectedFontSize: 15,
      //   unselectedFontSize: 14,
      //   unselectedIconTheme: const IconThemeData(color: Colors.black87),
      //   unselectedItemColor: const Color.fromRGBO(237, 236, 232, 1),
      //   type: BottomNavigationBarType.fixed,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: SvgPicture.asset(
      //         'assets/icons/home.svg',
      //         width: 28,
      //         height: 28,
      //         color: const Color.fromRGBO(27, 27, 27, 1),
      //       ),
      //       label: "Home",
      //       activeIcon: SvgPicture.asset(
      //         'assets/icons/home.svg',
      //         width: 28,
      //         height: 28,
      //         color: const Color.fromRGBO(247, 154, 0, 1),
      //       ),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: SvgPicture.asset(
      //         'assets/icons/adslist.svg',
      //         width: 28,
      //         height: 28,
      //         color: const Color.fromRGBO(27, 27, 27, 1),
      //       ),
      //       label: "Ads Alive",
      //       activeIcon: SvgPicture.asset(
      //         'assets/icons/adslist.svg',
      //         width: 28,
      //         height: 28,
      //         color: const Color.fromRGBO(247, 154, 0, 1),
      //       ),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: SvgPicture.asset(
      //         'assets/icons/addnewad.svg',
      //         width: 28,
      //         height: 28,
      //         color: const Color.fromRGBO(27, 27, 27, 1),
      //       ),
      //       label: "Lending",
      //       activeIcon: SvgPicture.asset(
      //         'assets/icons/addnewad.svg',
      //         width: 28,
      //         height: 28,
      //         color: const Color.fromRGBO(247, 154, 0, 1),
      //       ),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: SvgPicture.asset(
      //         'assets/icons/message.svg',
      //         width: 28,
      //         height: 28,
      //         color: const Color.fromRGBO(27, 27, 27, 1),
      //       ),
      //       label: "Profile",
      //       activeIcon: SvgPicture.asset(
      //         'assets/icons/message.svg',
      //         width: 28,
      //         height: 28,
      //         color: const Color.fromRGBO(247, 154, 0, 1),
      //       ),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: SvgPicture.asset(
      //         'assets/icons/person.svg',
      //         width: 28,
      //         height: 28,
      //         color: const Color.fromRGBO(27, 27, 27, 1),
      //       ),
      //       label: "Profile",
      //       activeIcon: SvgPicture.asset(
      //         'assets/icons/person.svg',
      //         width: 28,
      //         height: 28,
      //         color: const Color.fromRGBO(247, 154, 0, 1),
      //       ),
      //     ),
      //   ],
      // ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 25),
          child: BlurryContainer(
            height: 64,
            blur: 4.5,
            color: const Color.fromRGBO(49, 50, 54, 1).withOpacity(0.75),
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...List.generate(
                  pagelist.length,
                  (index) => GestureDetector(
                    onTap: () {
                      if (index != _pageindex) {
                        setState(() {
                          _pageindex = index;
                        });
                      }
                    },
                    child: Column(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(bottom: 2),
                          height: 4,
                          width: index == _pageindex ? 25 : 0,
                          decoration: const BoxDecoration(
                            color: Color(0xFF81B4FF),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: index == _pageindex ? 30 : 28,
                          width: index == _pageindex ? 34 : 32,
                          child: SvgPicture.asset(
                            Constants.bottomBarIcons[index],
                            color: index == _pageindex
                                ? Colors.white.withOpacity(0.8)
                                : Colors.white.withOpacity(0.35),
                          ),
                        ),
                      ],
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
