import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:photo_view/photo_view.dart';

class LocalImageContainer extends StatelessWidget {
  const LocalImageContainer({super.key, required this.file});
  final File file;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: PhotoView(
        imageProvider: FileImage(file),
      ),
    );
  }
}
