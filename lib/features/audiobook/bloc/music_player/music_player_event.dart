part of 'music_player_bloc.dart';

abstract class MusicPlayerEvent extends Equatable {
  const MusicPlayerEvent();

  @override
  List<Object> get props => [];
}

class MusicPlayerStarted extends MusicPlayerEvent {}

class MusicPlayerPlay extends MusicPlayerEvent {}

class MusicPlayerPause extends MusicPlayerEvent {}

class MusicPlayerPrev extends MusicPlayerEvent {}

class MusicPlayerNext extends MusicPlayerEvent {}

class MusicPlayerSeek extends MusicPlayerEvent {
  final Duration position;
  const MusicPlayerSeek({required this.position});
}

class MusicPlayerSetCurrentSong extends MusicPlayerEvent {
  final AudioDetailsData song;

  const MusicPlayerSetCurrentSong({required this.song});

  @override
  List<Object> get props => [song];
}

class MusicPlayerSetCurrentQueue extends MusicPlayerEvent {
  final List<AudioDetailsData> song;

  const MusicPlayerSetCurrentQueue({required this.song});

  @override
  List<Object> get props => [song];
}

class MusicPlayerAddSong extends MusicPlayerEvent {
  final AudioDetailsData song;
  const MusicPlayerAddSong({required this.song});
}
