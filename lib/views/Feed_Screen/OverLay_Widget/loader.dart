import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Loader {
  static final Loader appLoader = Loader();
  ValueNotifier<bool> loaderShowingNotifier = ValueNotifier(false);
  ValueNotifier<String> loaderImageURLNotifier = ValueNotifier('error message');
  ValueNotifier<VideoPlayerController> loaderVideoControllerNotifier =
      ValueNotifier(VideoPlayerController.network('Error Message'));
  ValueNotifier<bool> loaderIsImageOrVideo = ValueNotifier(true);

  void showLoader() {
    loaderShowingNotifier.value = true;
  }

  void isImage(bool val) {
    loaderIsImageOrVideo.value = val;
  }

  void hideLoader() {
    loaderShowingNotifier.value = false;
  }

  void setImage(String imageURl) {
    loaderImageURLNotifier.value = imageURl;
  }

  void setVideo(VideoPlayerController videoController) {
    loaderVideoControllerNotifier.value = videoController;
  }
}
