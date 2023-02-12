import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/size_config.dart';
import '../Feed Screen/feed_screen.dart';
import '../Job Internship Screen /job_internship_screen.dart';
import '../Demo Screens/Screen3.dart';
import '../Demo Screens/Screen4.dart';

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
    const Screen3(),
    const Screen4(),
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
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: const Color(0xFF17203A).withOpacity(0.8),
            borderRadius: const BorderRadius.all(Radius.circular(24)),
          ),
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
                      SizedBox(
                        height: 36,
                        width: 36,
                        child: Opacity(
                          opacity: index == _pageindex ? 1 : 0.5,
                          child: SvgPicture.asset(
                            'assets/Icons/home.svg',
                            width: getProportionateScreenWidth(21),
                            height: getProportionateScreenHeight(21),
                            color: Colors.white60,
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
    );
  }
}
