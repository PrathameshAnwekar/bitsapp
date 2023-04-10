import 'dart:io';

import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/feed_post.dart';
import 'package:bitsapp/services/firestore_service.dart';
import 'package:bitsapp/services/logger_service.dart';
import 'package:bitsapp/views/components/person_detail.dart';
import 'package:bitsapp/views/new_post_screen/components/local_media_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../components/circle_profile_pic.dart';

class NewPostScreen extends HookConsumerWidget {
  NewPostScreen({super.key});
  static const String routeName = "/new_post_screen";
  Map<File, String> mp = {};
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    final files = useState(mp);
    final localUser = ref.watch(localUserProvider);
    dlog(files.value.toString());
    final loading = useState(false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        title: const Text("Create a post"),
        centerTitle: false,
        backgroundColor: Colors.white,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Divider(thickness: 0.4),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              final FeedPost feedPost = FeedPost(
                timeuid: DateTime.now().millisecondsSinceEpoch.toString(),
                posterUid: localUser.uid,
                comments: [],
                likes: [],
                mediaFilesList: [],
                text: textController.text,
              );
              loading.value = true;
              await FirestoreService.addFeedPost(feedPost, files.value, ref)
                  .then((value) => loading.value = false);
            },
            child: Container(
              width: 72,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF4D5470),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
              child: const Text("Post",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 12, bottom: 100),
        child: SpeedDial(
          animationDuration: const Duration(milliseconds: 300),
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: const IconThemeData(color: Colors.white),
          spaceBetweenChildren: 3,
          backgroundColor: const Color(0xFF4D5470).withOpacity(0.8),
          spacing: 3,
          children: [
            SpeedDialChild(
              child: const Icon(
                Icons.add_photo_alternate_rounded,
                color: Color(0xFF4D5470),
              ),
              onTap: () => capture("image", files),
            ),
            SpeedDialChild(
              child: const Icon(
                Icons.video_camera_back_rounded,
                color: Color(0xFF4D5470),
              ),
              onTap: () => capture("video", files),
            ),
          ],
        ),
      ),
      body: loading.value
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        const CircleProfilePic(radius: 20),
                        const Spacer(flex: 1),
                        PersonDetail(user: localUser, isSmall: true, time: null,),
                        const Spacer(flex: 25),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: textController,
                      cursorColor: Colors.black54,
                      minLines: 10,
                      maxLines: 20,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(top: 20, left: 3, right: 3),
                        hintText: 'What do you want to talk about?',
                        hintStyle: GoogleFonts.dmSans(
                          fontSize: 17,
                          color: const Color.fromRGBO(0, 0, 0, 0.25),
                        ),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                      style: const TextStyle(
                        fontSize: 17,
                        color: Color.fromRGBO(27, 27, 27, 1),
                      ),
                    ),
                    LocalMediaContainer(files: files.value)
                  ],
                ),
              ),
            ),
    );
  }
}

Future capture(String source, ValueNotifier files) async {
  final getMedia =
      source == "image" ? ImagePicker().pickImage : ImagePicker().pickVideo;
  final media = await getMedia(source: ImageSource.gallery);
  final file = File(media!.path);
  files.value.addAll({file: source});
  files.notifyListeners();
}
