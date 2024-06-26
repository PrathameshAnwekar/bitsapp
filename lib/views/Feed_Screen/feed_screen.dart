import 'package:bitsapp/controllers/feed_screen_controller.dart';
import 'package:bitsapp/models/feed_post.dart';
import 'package:bitsapp/services/firestore_feed_service.dart';
import 'package:bitsapp/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../constants/constants.dart';
import '../notifications_screen/notification_screen.dart';
import 'feed_container/feed_container.dart';
import 'navigation_drawer.dart';

class FeedScreen extends ConsumerWidget {
  FeedScreen({super.key});

  final RefreshController _refreshController1 =
      RefreshController(initialRefresh: false);
  void _onRefresh(WidgetRef ref) async {
    // monitor network fetch
    await FirestoreFeedService.initFeedPosts(ref);
    // if failed,use refreshFailed()
    _refreshController1.refreshCompleted();
  }

  void _onLoading(List<FeedPost> feedposts) async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());

    _refreshController1.loadComplete();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedPosts = ref.watch(feedPostDataProvider);
    return Scaffold(
      drawer: const CustomDrawer(),
      extendBody: true,
      backgroundColor: Constants.kSecondaryColor,
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
              toolbarHeight: 60,
              // systemOverlayStyle: const SystemUiOverlayStyle(
              //   statusBarColor: Colors.white,
              //   statusBarIconBrightness: Brightness.dark,
              //   statusBarBrightness: Brightness.light,
              // ),
              leading: Padding(
                padding: const EdgeInsets.only(left: 6, top: 5, bottom: 7),
                child: IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: SvgPicture.asset(
                    'assets/icons/menu.svg',
                    height: 32,
                    width: 32,
                    color: Colors.blueGrey.shade600,
                  ),
                ),
              ),
              title: GestureDetector(
                onTap: () {
                  FeedScreenController.goToSearch(context, ref);
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 6, right: 6, bottom: 2),
                  height: 45,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: const BoxDecoration(
                    color: Constants.kSecondaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SvgPicture.asset(
                        'assets/icons/search.svg',
                        height: 22,
                        color: Colors.blueGrey.shade700,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Search",
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          color: Colors.blueGrey.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const NotificationsScreen(),
                      duration: const Duration(milliseconds: 200),
                    ),
                  ),
                  icon: SvgPicture.asset(
                    'assets/icons/notification_on.svg',
                    height: 32,
                    width: 32,
                    color: Colors.blueGrey.shade600,
                  ),
                ),
              ],
              centerTitle: true,
            ),
          ],
          body: SmartRefresher(
            key: const ValueKey("Feed"),
            enablePullDown: true,
            enablePullUp: false,
            controller: _refreshController1,
            header: const MaterialClassicHeader(
              color: Constants.kPrimaryColor,
            ),
            onLoading: () => _onLoading(feedPosts),
            onRefresh: () => _onRefresh(ref),
            child: ListView.builder(
              addAutomaticKeepAlives: true,
              addRepaintBoundaries: false,
              itemCount: feedPosts.length,
              itemBuilder: (BuildContext context, int index) {
                final key = ObjectKey(feedPosts[index]);
                bool isLastIndex = (index == (feedPosts.length - 1));
                return Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: isLastIndex ? 10 : 0,
                  ),
                  child: FeedContainer(
                    key: key,
                    feedPost: feedPosts[index],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
