import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:video_player/video_player.dart';

import '../../../constants/size_config.dart';
import '../Comment Screen/comment_screen.dart';
import '../OverLay Widget/loader.dart';

class NewFeedContainer extends StatefulWidget {
  const NewFeedContainer(
      {Key? key,
      required this.name,
      required this.time,
      required this.desc,
      required this.profilePicURL,
      required this.imageURL,
      required this.videoURL})
      : super(key: key);

  final String name;
  final String time;
  final String desc;
  final String profilePicURL;
  final List<String> imageURL;
  final List<String> videoURL;

  @override
  State<NewFeedContainer> createState() => _NewFeedContainerState();
}

class _NewFeedContainerState extends State<NewFeedContainer> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  ///FUNCTIONS////
  void _showImage(url) {
    Loader.appLoader.showLoader();
    Loader.appLoader.setImage(url);
    Loader.appLoader.isImage(true);
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      widget.videoURL[0],
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(false);
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
              CircleAvatar(
                radius: 23,
                backgroundImage: NetworkImage(widget.profilePicURL),
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

          // child: CachedNetworkImage(
          //   imageUrl: widget.imageURL[0],
          //   placeholder: (context, url) => Container(
          //       padding: const EdgeInsets.all(10),
          //       height: SizeConfig.screenHeight * 0.3,
          //       width: SizeConfig.screenWidth * 0.8,
          //       child: const Center(child: CircularProgressIndicator())),
          //   errorWidget: (context, url, error) => const Icon(Icons.error),
          // ),
          SizedBox(
            height: 430,
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: widget.imageURL.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => _showImage(widget.imageURL[index]),
                  child: Hero(
                    transitionOnUserGestures: true,
                    tag: widget.imageURL[index],
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: SizeConfig.screenWidth - 22,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              widget.imageURL[index],
                              fit: BoxFit.cover,
                            ),
                            // child: DropShadowImage(
                            //   blurRadius: 40,
                            //   offset: const Offset(0, 16),
                            //   image: Image.network(widget.imageURL[index],),
                            // ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // SizedBox(
          //   height: 250,
          //   child: PhotoViewGallery.builder(
          //     scrollDirection: Axis.horizontal,
          //     itemCount: widget.imageURL.length,
          //     builder: (ctx, index) {
          //       return PhotoViewGalleryPageOptions(
          //         heroAttributes: PhotoViewHeroAttributes(tag: widget),
          //         imageProvider: NetworkImage(widget.imageURL[index]),
          //       );
          //     },
          //   ),
          // ),

          // const SizedBox(height: 15),
          // //VIDEOPlayer
          // FutureBuilder(
          //     future: _initializeVideoPlayerFuture,
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.done) {
          //         return GestureDetector(
          //           onTap: () {
          //             setState(() {
          //               if (_controller.value.isPlaying) {
          //                 _controller.pause();
          //               } else {
          //                 _controller.play();
          //               }
          //             });
          //           },
          //           child: AspectRatio(
          //             aspectRatio: _controller.value.aspectRatio,
          //             // Use the VideoPlayer widget to display the video.
          //             child: VideoPlayer(_controller),
          //           ),
          //         );
          //       } else {
          //         // If the VideoPlayerController is still initializing, show a
          //         // loading spinner.
          //         return const Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       }
          //     }),
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
