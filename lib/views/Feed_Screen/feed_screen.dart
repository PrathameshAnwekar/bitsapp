import 'package:bitsapp/controllers/feed_screen_controller.dart';
import 'package:bitsapp/models/feed_post.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'feed_container/feed_container.dart';

class FeedScreen extends ConsumerWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedPosts = ref.watch(feedPostDataProvider);
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.grey.withOpacity(.17),
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
              title: GestureDetector(
                onTap: () {
                  FeedScreenController.goToSearch(context, ref);
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 6, right: 6, bottom: 3),
                  height: 42,
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SvgPicture.asset(
                        'assets/icons/search.svg',
                        height: 22,
                        color: Colors.black.withOpacity(0.8),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Search",
                        style: GoogleFonts.dmSans(
                          fontSize: 16,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.settings_rounded,
                    size: 32,
                  ),
                ),
              ],
              centerTitle: true,
            ),
          ],
          body: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ListView.builder(
              itemCount: feedPosts.length,
              itemBuilder: (BuildContext context, int index) {
                final key = ObjectKey(feedPosts[index]);
                return Padding(
                  padding: EdgeInsets.only(top: index == 0 ? 10 : 0),
                  child: FeedContainer(key: key,
                      feedPost: feedPosts[index]),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
