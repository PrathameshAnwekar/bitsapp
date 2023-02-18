import 'package:bitsapp/views/Components/person_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../Components/circle_profile_pic.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Create a post"),
        centerTitle: false,
        backgroundColor: Colors.white,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Divider(thickness: 0.4),
        ),
        actions: [
          Container(
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
              onTap: () {},
            ),
            SpeedDialChild(
              child: const Icon(
                Icons.video_camera_back_rounded,
                color: Color(0xFF4D5470),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: const [
                  CircleProfilePic(radius: 20),
                  Spacer(flex: 1),
                  PersonDetail(),
                  Spacer(flex: 25),
                ],
              ),
              const SizedBox(height: 10),
              TextFormField(
                cursorColor: Colors.black54,
                minLines: 10,
                maxLines: 20,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(top: 20, left: 3, right: 3),
                  hintText: 'What do you want to talk about?',
                  hintStyle: TextStyle(
                    fontSize: 17,
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                ),
                style: const TextStyle(
                  fontSize: 17,
                  color: Color.fromRGBO(27, 27, 27, 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
