import 'package:comment_tree/data/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe_to/swipe_to.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key? key}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  FocusNode focusNode = FocusNode();
  PreferredSize avatarRoot(Comment data) {
    return PreferredSize(
      child: Padding(
        padding: const EdgeInsets.only(top: 3),
        child: CircleAvatar(
          radius: 18,
          backgroundColor: Colors.grey,
          backgroundImage: NetworkImage(data.avatar!),
        ),
      ),
      preferredSize: const Size.fromRadius(18),
    );
  }

  PreferredSize avatarChild(Comment data) {
    return PreferredSize(
      child: Padding(
        padding: const EdgeInsets.only(top: 3),
        child: CircleAvatar(
          radius: 16,
          backgroundColor: Colors.grey,
          backgroundImage: NetworkImage(data.avatar!),
        ),
      ),
      preferredSize: const Size.fromRadius(16),
    );
  }

  Widget contentChild(Comment data) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(11),
            decoration: const BoxDecoration(
              // color: Color.fromRGBO(43, 62, 72, 1),
              // color: Color.fromRGBO(63, 141, 253, 1),
              // color: Color.fromRGBO(114, 110, 245, 1),
              // color: Color.fromRGBO(11, 172, 184, 1),
              // color: Color.fromRGBO(120, 112, 230, 1),
              color: Color.fromRGBO(97, 88, 198, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${data.userName}',
                  style: GoogleFonts.lato(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  '${data.content}',
                  style: GoogleFonts.lato(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          DefaultTextStyle(
            style: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(color: Colors.grey[700], fontWeight: FontWeight.bold),
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                children: const [
                  SizedBox(
                    width: 8,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onSwippedMessage(Comment data) {
    focusNode.requestFocus();
  }

  Widget contentRoot(Comment data) {
    return SwipeTo(
      offsetDx: 0.2,
      onRightSwipe: () => onSwippedMessage(data),
      animationDuration: const Duration(milliseconds: 100),
      child: Padding(
        padding: const EdgeInsets.only(right: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(11),
              decoration: const BoxDecoration(
                // color: Color.fromRGBO(49, 49, 49, 1),
                // color: Color.fromRGBO(49, 50, 54, 1),
                // color: Color.fromRGBO(50, 51, 55, 1),
                color: Color.fromRGBO(38, 45, 58, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${data.userName}',
                    style: GoogleFonts.lato(
                      color: Colors.white.withOpacity(0.98),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    '${data.content}',
                    style: GoogleFonts.lato(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            DefaultTextStyle(
              style: Theme.of(context).textTheme.caption!.copyWith(
                  color: const Color.fromRGBO(173, 164, 165, 1),
                  fontWeight: FontWeight.bold),
              child: GestureDetector(
                onTap: () => onSwippedMessage(data),
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    children: const [
                      SizedBox(
                        width: 8,
                      ),
                      Text('Reply'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      // statusBarColor: Color.fromRGBO(32, 33, 37, 1),
      // statusBarColor: Color.fromRGBO(25, 29, 30, 1),
      statusBarColor: Color.fromRGBO(28, 31, 42, 1),
      // statusBarColor: Colors.transparent,
    ));
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => focusNode.unfocus(),
        child: Scaffold(
          // extendBodyBehindAppBar: true,
          // backgroundColor: const Color.fromRGBO(32, 33, 37, 1),
          // backgroundColor: const Color.fromRGBO(25, 29, 30, 1),
          backgroundColor: const Color.fromRGBO(28, 31, 42, 1),
          resizeToAvoidBottomInset: true,
          appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 60),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(29, 31, 42, 1),
                    Color.fromRGBO(20, 24, 34, 1)
                  ],
                ),
              ),
              child: AppBar(
                title: Text(
                  'Comments',
                  style: GoogleFonts.manrope(color: Colors.white, fontSize: 20),
                ),
                // backgroundColor: const Color.fromRGBO(28, 31, 42, 1),
                backgroundColor: Colors.transparent,
                // backgroundColor: const Color.fromRGBO(32, 33, 37, 1),
                // backgroundColor: const Color.fromRGBO(25, 29, 30, 1),
                // backgroundColor: const Color.fromRGBO(28, 31, 42, 1),
                elevation: 0,
              ),
            ),
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(29, 31, 42, 1),
                  Color.fromRGBO(20, 24, 34, 1)
                ],
              ),
            ),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        CommentTreeWidget<Comment, Comment>(
                          Comment(
                              avatar:
                                  'https://media-exp1.licdn.com/dms/image/C4E03AQEpTA4E1XHhLw/profile-displayphoto-shrink_400_400/0/1624958744829?e=1650499200&v=beta&t=EjkB4H-PxOQ2e68Qpvp5kia0dBXGTcTqsfhs67HMnAA',
                              userName: 'Prathamesh Anwekar',
                              content:
                                  'I love flutter, dsa and competitve program and I am good in it'),
                          [
                            Comment(
                                avatar:
                                    'https://media-exp1.licdn.com/dms/image/C4D03AQGm3EQTvKXtKg/profile-displayphoto-shrink_800_800/0/1631084700638?e=1650499200&v=beta&t=bu0NN0ZqcNX5KOKrvNZNyEIxx5dZ9Gp5YeZirERWI4Q',
                                userName: 'Arya Bamboli',
                                content:
                                    'A Dart template generator which helps teams Birla Institute of Technology and Science, pilani'),
                            Comment(
                                avatar:
                                    'https://media-exp1.licdn.com/dms/image/C5603AQEdvxtGH5fkow/profile-displayphoto-shrink_100_100/0/1607626725465?e=1651104000&v=beta&t=iypTSO6VF8mllZ3AGhs18jOxPhVzQ7ArziIbpUDct50',
                                userName: 'Vedant Verma',
                                content:
                                    'A Dart template generator which helps teams generator which helps teams generator which helps teams'),
                          ],
                          treeThemeData: const TreeThemeData(
                              lineColor: Colors.grey, lineWidth: 2.8),
                          avatarRoot: (context, data) => avatarRoot(data),
                          avatarChild: (context, data) => avatarChild(data),
                          contentChild: (context, data) => contentChild(data),
                          contentRoot: (context, data) => Container(
                            child: contentRoot(data),
                          ),
                        ),
                        CommentTreeWidget<Comment, Comment>(
                          Comment(
                              avatar:
                                  'https://media-exp1.licdn.com/dms/image/C4E03AQEpTA4E1XHhLw/profile-displayphoto-shrink_400_400/0/1624958744829?e=1650499200&v=beta&t=EjkB4H-PxOQ2e68Qpvp5kia0dBXGTcTqsfhs67HMnAA',
                              userName: 'Prathamesh Anwekar',
                              content: 'I love flutter'),
                          [
                            Comment(
                                avatar:
                                    'https://media-exp1.licdn.com/dms/image/C4D03AQGm3EQTvKXtKg/profile-displayphoto-shrink_800_800/0/1631084700638?e=1650499200&v=beta&t=bu0NN0ZqcNX5KOKrvNZNyEIxx5dZ9Gp5YeZirERWI4Q',
                                userName: 'Arya Bamboli',
                                content:
                                    'A Dart template generator which helps teams'),
                            Comment(
                                avatar:
                                    'https://media-exp1.licdn.com/dms/image/C5603AQEdvxtGH5fkow/profile-displayphoto-shrink_100_100/0/1607626725465?e=1651104000&v=beta&t=iypTSO6VF8mllZ3AGhs18jOxPhVzQ7ArziIbpUDct50',
                                userName: 'Vedant Verma',
                                content:
                                    'A Dart template generator which helps teams generator which helps teams generator which helps teams'),
                          ],
                          treeThemeData: const TreeThemeData(
                              lineColor: Colors.grey, lineWidth: 2.8),
                          avatarRoot: (context, data) => avatarRoot(data),
                          avatarChild: (context, data) => avatarChild(data),
                          contentChild: (context, data) => contentChild(data),
                          contentRoot: (context, data) => contentRoot(data),
                        ),
                        CommentTreeWidget<Comment, Comment>(
                          Comment(
                              avatar:
                                  'https://media-exp1.licdn.com/dms/image/C4E03AQEpTA4E1XHhLw/profile-displayphoto-shrink_400_400/0/1624958744829?e=1650499200&v=beta&t=EjkB4H-PxOQ2e68Qpvp5kia0dBXGTcTqsfhs67HMnAA',
                              userName: 'Prathamesh Anwekar',
                              content: 'I love flutter'),
                          [
                            Comment(
                                avatar:
                                    'https://media-exp1.licdn.com/dms/image/C4D03AQGm3EQTvKXtKg/profile-displayphoto-shrink_800_800/0/1631084700638?e=1650499200&v=beta&t=bu0NN0ZqcNX5KOKrvNZNyEIxx5dZ9Gp5YeZirERWI4Q',
                                userName: 'Arya Bamboli',
                                content:
                                    'A Dart template generator which helps teams'),
                            Comment(
                                avatar:
                                    'https://media-exp1.licdn.com/dms/image/C5603AQEdvxtGH5fkow/profile-displayphoto-shrink_100_100/0/1607626725465?e=1651104000&v=beta&t=iypTSO6VF8mllZ3AGhs18jOxPhVzQ7ArziIbpUDct50',
                                userName: 'Vedant Verma',
                                content:
                                    'A Dart template generator which helps teams generator which helps teams generator which helps teams'),
                          ],
                          treeThemeData: const TreeThemeData(
                              lineColor: Colors.grey, lineWidth: 2.8),
                          avatarRoot: (context, data) => avatarRoot(data),
                          avatarChild: (context, data) => avatarChild(data),
                          contentChild: (context, data) => contentChild(data),
                          contentRoot: (context, data) => contentRoot(data),
                        ),
                        CommentTreeWidget<Comment, Comment>(
                          Comment(
                              avatar:
                                  'https://media-exp1.licdn.com/dms/image/C4E03AQEpTA4E1XHhLw/profile-displayphoto-shrink_400_400/0/1624958744829?e=1650499200&v=beta&t=EjkB4H-PxOQ2e68Qpvp5kia0dBXGTcTqsfhs67HMnAA',
                              userName: 'Prathamesh Anwekar',
                              content: 'I love flutter'),
                          [
                            Comment(
                                avatar:
                                    'https://media-exp1.licdn.com/dms/image/C4D03AQGm3EQTvKXtKg/profile-displayphoto-shrink_800_800/0/1631084700638?e=1650499200&v=beta&t=bu0NN0ZqcNX5KOKrvNZNyEIxx5dZ9Gp5YeZirERWI4Q',
                                userName: 'Arya Bamboli',
                                content:
                                    'A Dart template generator which helps teams'),
                            Comment(
                                avatar:
                                    'https://media-exp1.licdn.com/dms/image/C5603AQEdvxtGH5fkow/profile-displayphoto-shrink_100_100/0/1607626725465?e=1651104000&v=beta&t=iypTSO6VF8mllZ3AGhs18jOxPhVzQ7ArziIbpUDct50',
                                userName: 'Vedant Verma',
                                content:
                                    'A Dart template generator which helps teams generator which helps teams generator which helps teams'),
                          ],
                          treeThemeData: const TreeThemeData(
                              lineColor: Colors.grey, lineWidth: 2.8),
                          avatarRoot: (context, data) => avatarRoot(data),
                          avatarChild: (context, data) => avatarChild(data),
                          contentChild: (context, data) => contentChild(data),
                          contentRoot: (context, data) => contentRoot(data),
                        ),
                        CommentTreeWidget<Comment, Comment>(
                          Comment(
                              avatar:
                                  'https://media-exp1.licdn.com/dms/image/C4E03AQEpTA4E1XHhLw/profile-displayphoto-shrink_400_400/0/1624958744829?e=1650499200&v=beta&t=EjkB4H-PxOQ2e68Qpvp5kia0dBXGTcTqsfhs67HMnAA',
                              userName: 'Prathamesh Anwekar',
                              content: 'I love flutter'),
                          [
                            Comment(
                                avatar:
                                    'https://media-exp1.licdn.com/dms/image/C4D03AQGm3EQTvKXtKg/profile-displayphoto-shrink_800_800/0/1631084700638?e=1650499200&v=beta&t=bu0NN0ZqcNX5KOKrvNZNyEIxx5dZ9Gp5YeZirERWI4Q',
                                userName: 'Arya Bamboli',
                                content:
                                    'A Dart template generator which helps teams'),
                            Comment(
                                avatar:
                                    'https://media-exp1.licdn.com/dms/image/C5603AQEdvxtGH5fkow/profile-displayphoto-shrink_100_100/0/1607626725465?e=1651104000&v=beta&t=iypTSO6VF8mllZ3AGhs18jOxPhVzQ7ArziIbpUDct50',
                                userName: 'Vedant Verma',
                                content:
                                    'A Dart template generator which helps teams generator which helps teams generator which helps teams'),
                          ],
                          treeThemeData: const TreeThemeData(
                              lineColor: Colors.grey, lineWidth: 2.8),
                          avatarRoot: (context, data) => avatarRoot(data),
                          avatarChild: (context, data) => avatarChild(data),
                          contentChild: (context, data) => contentChild(data),
                          contentRoot: (context, data) => contentRoot(data),
                        ),
                        const SizedBox(
                          height: 70,
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: TextFormField(
                    style: GoogleFonts.manrope(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    focusNode: focusNode,
                    textCapitalization: TextCapitalization.none,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    cursorColor: Colors.grey,
                    cursorRadius: const Radius.elliptical(2, 2),
                    cursorWidth: 2,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                          top: 22.5, left: 12, right: 12, bottom: 22.5),
                      hintText: 'Add a comment...',
                      hintStyle: GoogleFonts.dmSans(
                        fontSize: 17,
                        color: Colors.white70,
                      ),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(
                            left: 10, top: 12, bottom: 12, right: 10),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(
                              'https://media-exp1.licdn.com/dms/image/C4E03AQEpTA4E1XHhLw/profile-displayphoto-shrink_400_400/0/1624958744829?e=1650499200&v=beta&t=EjkB4H-PxOQ2e68Qpvp5kia0dBXGTcTqsfhs67HMnAA'),
                        ),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(
                            left: 5, top: 8, bottom: 8, right: 10),
                        child: SvgPicture.asset(
                          'assets/icons/enter.svg',
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      filled: true,
                      // fillColor: const Color.fromRGBO(49, 50, 54, 1),
                      fillColor: const Color.fromRGBO(38, 45, 58, 1),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(14),
                          topRight: Radius.circular(14),
                        ),
                        borderSide: BorderSide.none,
                      ),
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
