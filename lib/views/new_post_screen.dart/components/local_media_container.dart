import 'dart:io';

import 'package:bitsapp/views/New_Post_Screen.dart/components/local_image_container.dart';
import 'package:bitsapp/views/New_Post_Screen.dart/components/local_video_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocalMediaContainer extends StatelessWidget {
  const LocalMediaContainer({super.key, required this.files});
  final Map<File, String> files;
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        cacheExtent: files.length * 300,
        scrollDirection: Axis.horizontal,
        itemCount: files.length,
        itemBuilder: (context, index) {
          final file = files.keys.elementAt(index);
          final type = files[file];
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
