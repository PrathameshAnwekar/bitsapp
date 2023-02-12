import 'package:bitsapp/views/auth/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/size_config.dart';
import '../Demo Screens/Screen3.dart';
import '../Demo Screens/Screen4.dart';
import '../Feed Screen/feed_screen.dart';
import '../Job Internship Screen /job_internship_screen.dart';
// import 'Job Internship Screen/job_internship_screen.dart';
// import 'Profile Screen/userprofile_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({Key? key}) : super(key: key);
  static const routeName = '/feed-screen';

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  final Color _activeColor = Colors.white;
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
      // backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      extendBody: true,
      bottomNavigationBar: SnakeNavigationBar.color(
        height: getProportionateScreenHeight(100),
        behaviour: SnakeBarBehaviour.pinned,
        snakeShape: SnakeShape.indicator,
        currentIndex: _pageindex,
        backgroundColor: const Color.fromRGBO(25, 29, 30, 1),
        // backgroundColor: const Color.fromRGBO(32, 33, 37, 1),
        showUnselectedLabels: false,
        showSelectedLabels: false,
        onTap: (value) {
          setState(() {
            _pageindex = value;
          });
        },
        snakeViewColor: Colors.white54,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              width: getProportionateScreenWidth(21),
              height: getProportionateScreenHeight(21),
              color: Colors.white60,
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/home.svg',
              width: getProportionateScreenWidth(23),
              height: getProportionateScreenHeight(23),
              color: _activeColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/addnewad.svg',
              width: getProportionateScreenWidth(21),
              height: getProportionateScreenHeight(21),
              color: Colors.white60,
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/addnewad.svg',
              width: getProportionateScreenWidth(23),
              height: getProportionateScreenHeight(23),
              color: _activeColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/cart.svg',
              width: getProportionateScreenWidth(21),
              height: getProportionateScreenHeight(21),
              color: Colors.white60,
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/cart.svg',
              width: getProportionateScreenWidth(23),
              height: getProportionateScreenHeight(23),
              color: _activeColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/adslist.svg',
              width: getProportionateScreenWidth(21),
              height: getProportionateScreenHeight(21),
              color: Colors.white60,
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/adslist.svg',
              width: getProportionateScreenWidth(23),
              height: getProportionateScreenHeight(23),
              color: _activeColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/person.svg',
              width: getProportionateScreenWidth(21),
              height: getProportionateScreenHeight(21),
              color: Colors.white60,
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/person.svg',
              width: getProportionateScreenWidth(23),
              height: getProportionateScreenHeight(23),
              color: _activeColor,
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: _pageindex,
        children: pagelist,
      ),
    );
  }
}
