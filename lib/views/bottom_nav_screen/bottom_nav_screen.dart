import 'package:bitsapp/views/chat/chats_screen.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/constants.dart';
import '../feed_screen/feed_screen.dart';
import '../job_internship_screen/job_internship_screen.dart';
import '../new_post_screen.dart/new_post_screen.dart';
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
    const FeedScreen(),
    const JobInternhipScreen(),
    const NewPostScreen(),
    const ChatsScreen(),
    const Screen4(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: IndexedStack(
        index: _pageindex,
        children: pagelist,
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: BlurryContainer(
            height: 62,
            blur: 4.5,
            color: const Color.fromRGBO(49, 50, 54, 1).withOpacity(0.75),
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            padding: const EdgeInsets.all(12),
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(bottom: 2),
                          height: 4,
                          width: index == _pageindex ? 20 : 0,
                          decoration: const BoxDecoration(
                            color: Color(0xFF81B4FF),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: index == _pageindex ? 30 : 28,
                          width: index == _pageindex ? 34 : 32,
                          child: Opacity(
                            opacity: index == _pageindex ? 1 : 0.5,
                            child: SvgPicture.asset(
                              Constants.bottomBarIcons[index],
                              color: index == _pageindex
                                  ? Colors.white.withOpacity(0.65)
                                  : Colors.white.withOpacity(0.5),
                            ),
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
