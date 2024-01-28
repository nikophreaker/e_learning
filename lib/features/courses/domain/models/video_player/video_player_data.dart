import 'package:e_learning/features/courses/domain/models/lesson/lesson_data.dart';

class VideoPlayerData {
  final LessonData? currentVideo;
  final List<LessonData> videoQueue;

  VideoPlayerData({
    this.currentVideo,
    required this.videoQueue,
  });
}