import 'dart:async';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

class VideoRepository {
  VideoRepository({required this.flickManager, required this.urls});

  int currentPlaying = 0;
  final FlickManager flickManager;
  final List<String> urls;

  late Timer videoChangeTimer;

  String getNextVideo() {
    currentPlaying++;
    return urls[currentPlaying];
  }

  bool hasNextVideo() {
    return currentPlaying != urls.length - 1;
  }

  bool hasPreviousVideo() {
    return currentPlaying != 0;
  }

  void skipToNextVideo([Duration? duration]) {
    if (hasNextVideo()) {
      flickManager.handleChangeVideo(
          VideoPlayerController.networkUrl(Uri.parse(urls[currentPlaying + 1])),
          videoChangeDuration: duration);

      ++currentPlaying;
    }
  }

  void skipToPreviousVideo() {
    if (hasPreviousVideo()) {
      currentPlaying--;
      flickManager.handleChangeVideo(
          VideoPlayerController.networkUrl(Uri.parse(urls[currentPlaying])));
    }
  }

  void cancelVideoAutoPlayTimer({required bool playNext}) {
    if (playNext != true) {
      currentPlaying--;
    }

    flickManager.flickVideoManager
        ?.cancelVideoAutoPlayTimer(playNext: playNext);
  }
}