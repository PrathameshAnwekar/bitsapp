import 'dart:io';

import 'package:bitsapp/views/new_post_screen/components/local_image_container.dart';
import 'package:bitsapp/views/new_post_screen/components/local_video_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//TODO: Option to remove a file from the list
class LocalMediaContainer extends StatelessWidget {
  const LocalMediaContainer({super.key, required this.files});
  final ValueNotifier<Map<File, String>> files;
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        cacheExtent: files.value.length * 300,
        scrollDirection: Axis.horizontal,
        itemCount: files.value.length,
        itemBuilder: (context, index) {
          final file = files.value.keys.elementAt(index);
          final type = files.value[file];
          if (type == 'image') {
            return LocalImageContainer(file: file);
          } else if (type == 'video') {
            return LocalVideoContainer(file: file);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
