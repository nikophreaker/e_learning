part of 'video_player_bloc.dart';

enum VideoPlayerStatus { initial, loaded, playing, paused, stopped }

class VideoPlayerState extends Equatable {
  final VideoPlayerStatus status;
  final VideoPlayerData? videoPlayerData;

  const VideoPlayerState({
    this.status = VideoPlayerStatus.initial,
    this.videoPlayerData,
  });

  VideoPlayerState copyWith({
    VideoPlayerStatus? status,
    VideoPlayerData? videoPlayerData,
  }) {
    return VideoPlayerState(
      status: status ?? this.status,
      videoPlayerData: videoPlayerData ?? this.videoPlayerData,
    );
  }

  @override
  List<Object?> get props => [status, videoPlayerData];
}
