import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

import '../../../constants/size_config.dart';
import '../Comment_Screen/comment_screen.dart';
import '../OverLay_Widget/loader.dart';

class NewFeedContainer extends StatefulWidget {
  const NewFeedContainer(
      {Key? key,
      required this.name,
      required this.time,
      required this.desc,
      required this.profilePicURL,
      required this.imageUrlList,
      required this.videoUrlList})
      : super(key: key);

  final String name;
  final String time;
  final String desc;
  final String profilePicURL;
  final List<String> imageUrlList;
  final List<String> videoUrlList;

  @override
  State<NewFeedContainer> createState() => _NewFeedContainerState();
}

class _NewFeedContainerState extends State<NewFeedContainer> {
  ///FUNCTIONS////
  void _showImage(url) {
    Loader.appLoader.showLoader();
    Loader.appLoader.setImage(url);
    Loader.appLoader.isImage(true);
  }

  ///FUNCTIONS////

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        // color: const Color.fromRGBO(49, 49, 49, 1),
        color: const Color.fromRGBO(49, 50, 54, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(32, 33, 37, 1),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: CachedNetworkImage(
                  imageUrl: widget.profilePicURL,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(
                width: 11,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.name,
                    style: GoogleFonts.manrope(
                        color: Colors.white.withOpacity(0.98), fontSize: 14),
                  ),
                  Text(
                    widget.time,
                    style:
                        GoogleFonts.manrope(color: Colors.grey, fontSize: 11),
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              Icon(
                Icons.more_vert_outlined,
                color: Colors.white.withOpacity(0.98),
                size: 24,
              )
            ],
          ),
          const SizedBox(height: 10),
          ReadMoreText(
            widget.desc,
            textAlign: TextAlign.start,
            colorClickableText: Colors.grey,
            style: GoogleFonts.manrope(color: Colors.white.withOpacity(0.98)),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 430,
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: widget.imageUrlList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => _showImage(widget.imageUrlList[index]),
                  child: Hero(
                    transitionOnUserGestures: true,
                    tag: widget.imageUrlList[index],
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: SizeConfig.screenWidth - 22,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: widget.imageUrlList[index],
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '123 likes',
                  style:
                      GoogleFonts.manrope(color: Colors.white.withOpacity(0.8)),
                ),
                Text(
                  '12 comments',
                  style:
                      GoogleFonts.manrope(color: Colors.white.withOpacity(0.8)),
                ),
              ],
            ),
          ),
          const Divider(
            height: 25,
            color: Colors.grey,
            indent: 14,
            endIndent: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SvgPicture.asset(
                'assets/icons/like.svg',
                width: 30,
                height: 30,
                color: Colors.white.withOpacity(0.8),
              ),
              GestureDetector(
                onTap: () {
                  print(DateTime.now());
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CommentScreen()));
                },
                child: SvgPicture.asset(
                  'assets/icons/comment.svg',
                  width: 30,
                  height: 30,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              SvgPicture.asset(
                'assets/icons/bookmark.svg',
                width: 30,
                height: 30,
                color: Colors.white.withOpacity(0.8),
              ),
              SvgPicture.asset(
                'assets/icons/share.svg',
                width: 30,
                height: 30,
                color: Colors.white.withOpacity(0.8),
              )
            ],
          ),
        ],
      ),
    );
  }
}
