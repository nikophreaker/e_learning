part of 'video_player_bloc.dart';

abstract class VideoPlayerEvent extends Equatable {
  const VideoPlayerEvent();

  @override
  List<Object> get props => [];
}

class VideoPlayerStarted extends VideoPlayerEvent {}

class VideoPlayerPlay extends VideoPlayerEvent {}

class VideoPlayerPause extends VideoPlayerEvent {}

class VideoPlayerPrev extends VideoPlayerEvent {}

class VideoPlayerNext extends VideoPlayerEvent {}

class VideoPlayerSeek extends VideoPlayerEvent {
  final Duration position;
  const VideoPlayerSeek({required this.position});
}
