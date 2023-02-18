import 'package:badges/badges.dart' as bd;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../chat/chats_screen.dart';
import 'Feed_Container/feed_container.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.grey.withOpacity(0.3),
      body: SafeArea(
        bottom: false,
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              scrolledUnderElevation: 0,
              backgroundColor: Colors.white,
              floating: true,
              snap: true,
              toolbarHeight: 55,
              leading: Padding(
                padding: const EdgeInsets.only(left: 6, top: 6, bottom: 6),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(32, 33, 37, 1),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(1000)),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl:
                          "https://media.istockphoto.com/id/1309328823/photo/headshot-portrait-of-smiling-male-employee-in-office.jpg?b=1&s=170667a&w=0&k=20&c=MRMqc79PuLmQfxJ99fTfGqHL07EDHqHLWg0Tb4rPXQc=",
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              title: Container(
                margin: const EdgeInsets.only(left: 6, right: 6, bottom: 3),
                height: 42,
                width: double.infinity,
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.04),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: const Color.fromRGBO(49, 50, 54, 1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/Icons/search.svg',
                      height: 22,
                      color: const Color.fromRGBO(49, 50, 54, 1),
                    ),
                    SvgPicture.asset(
                      'assets/Icons/filter.svg',
                      height: 22,
                      color: const Color.fromRGBO(49, 50, 54, 1),
                    ),
                  ],
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const ChatsScreen(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 14, bottom: 7),
                    child: SizedBox(
                      width: 40,
                      child: bd.Badge(
                        position: bd.BadgePosition.custom(top: -7, end: 1.8),
                        badgeContent: Text(
                          "2",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.dmSans(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        child: SvgPicture.asset(
                          'assets/Icons/message.svg',
                          width: 38,
                          height: 38,
                          color: const Color.fromRGBO(49, 50, 54, 1),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              centerTitle: true,
            ),
          ],
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView.separated(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return const FeedContainer();
              },
              separatorBuilder: (context, index) => const SizedBox(height: 16),
            ),
          ),
        ),
      ),
    );
  }
}
