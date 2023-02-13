import 'package:badges/badges.dart' as bd;
import 'package:bitsapp/views/chat/chats_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'OverLay_Widget/overlay_widget.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int countText = 0;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(32, 33, 37, 1),
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(25, 29, 32, 1),

      // backgroundColor: const Color.fromRGBO(32, 33, 37, 1),
      // or const Color.fromRGBO(33, 33, 33, 1),
      extendBody: true,
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  floating: true,
                  // snap: true,
                  backgroundColor: const Color.fromRGBO(25, 29, 32, 1),

                  // backgroundColor: const Color.fromRGBO(32, 33, 37, 1),
                  // or const Color.fromRGBO(33, 33, 33, 1),
                  toolbarHeight: 48,
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 6, top: 6, bottom: 6),
                    child: Container(
                      width: 28,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(32, 33, 37, 1),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://media-exp1.licdn.com/dms/image/C4D03AQGm3EQTvKXtKg/profile-displayphoto-shrink_800_800/0/1631084700638?e=1650499200&v=beta&t=bu0NN0ZqcNX5KOKrvNZNyEIxx5dZ9Gp5YeZirERWI4Q",
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  title: GestureDetector(
                    onTap: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (ctx) => const Screen2(),
                      //   ),
                      // );
                      setState(() {
                        countText++;
                      });
                    },
                    child: Container(
                      margin:
                          const EdgeInsets.only(left: 6, right: 6, bottom: 3),
                      height: 35,
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.04),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.85)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SvgPicture.asset(
                            'assets/Icons/search.svg',
                            height: 22,
                            color: Colors.white,
                          ),
                          SvgPicture.asset(
                            'assets/Icons/filter.svg',
                            color: Colors.white,
                            height: 22,
                          ),
                        ],
                      ),
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
                        padding: const EdgeInsets.only(right: 18),
                        child: Center(
                          child: SizedBox(
                            width: 30,
                            child: bd.Badge(
                              badgeContent: Text(
                                '$countText',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    color: Colors.white, fontSize: 13),
                              ),
                              child: SvgPicture.asset(
                                'assets/Icons/message.svg',
                                width: 35,
                                height: 35,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  centerTitle: true,
                  elevation: 0,
                )
              ],
              body: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 100,
                    color: Colors.green,
                  );
                  // return const NewFeedContainer(
                  //   name: 'Kunal Sharma',
                  //   time: '1 week ago',
                  //   desc:
                  //       'Hello everyone,\n\nI am elated to share that I have joined PayPal as a Software Engineer Intern for the Qing six months. \n\nI would like to thank Priyanka Nayak, Alpana Sharma and team for a smooth and timely onboarding process. Looking forward to the learnings and responsibilities! ✨️',
                  //   profilePicURL:
                  //       'https://images.hindustantimes.com/tech/img/2022/09/21/960x540/Iron_Man_game_1663763152566_1663763165963_1663763165963.jpg',
                  //   imageUrlList: [
                  //     'https://media.licdn.com/dms/image/sync/D5618AQHTKy8tcVfezA/companyUpdate-article-image-shrink_627_1200/0/1671705307092/Ad2post3png?e=1675900800&v=beta&t=hrhTpb_DOSSKM_5NIT67Q6tZhLmZuW3_2faHdcCDgbU',
                  //     'https://media.licdn.com/dms/image/C5622AQEgbz9ayGNEwg/feedshare-shrink_2048_1536/0/1673072293657?e=1675900800&v=beta&t=qC5zQeq62wBge9UhPYkUvc4mtFbV-sTUjHo9RKcWqSs',
                  //     'https://media-exp1.licdn.com/dms/image/C5622AQFDfkmhbYg8bw/feedshare-shrink_800/0/1648549869858?e=2147483647&v=beta&t=4FW6mJGYwZu2SwoovFLEEhZHRiA_RqRikYPUKh1nsSo',
                  //     'https://media.licdn.com/media/AAYQAQQSAAgAAQAAAAAAABwEEXEeLoHISM2cU9LdzliLaQ.gif'
                  //   ],
                  //   videoUrlList: [
                  //     'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'
                  //   ],
                  // );
                },
              ),
            ),
          ),
          const OverlayImage(),
        ],
      ),
    );
  }
}
