

import 'package:bloc/bloc.dart';
import 'package:e_learning/features/courses/domain/models/video_player/video_player_data.dart';
import 'package:e_learning/features/courses/domain/repository/video_player/video_repository.dart';
import 'package:equatable/equatable.dart';

part 'video_player_event.dart';
part 'video_player_state.dart';


class VideoPlayerBloc extends Bloc<VideoPlayerEvent, VideoPlayerState> {
  final VideoRepository _videoRepository;

  VideoPlayerBloc({
    required VideoRepository videoRepository,
  })  : _videoRepository = videoRepository,
        super(const VideoPlayerState()) {
    // on<VideoPlayerStarted>(_onStarted);
    // on<VideoPlayerPlay>(_onPlay);
    // on<VideoPlayerPause>(_onPause);
    on<VideoPlayerPrev>(_onPrev);
    on<VideoPlayerNext>(_onNext);
    // on<VideoPlayerSeek>(_onSeek);
    // on<MusicPlayerSetCurrentSong>(_onSetCurrentSong);
    // on<MusicPlayerSetCurrentQueue>(_onSetCurrentQueue);
    // on<MusicPlayerAddSong>(_onAddSong);
  }

  // void _onStarted(
  //     VideoPlayerStarted event,
  //     Emitter<VideoPlayerState> emit,
  //     ) async {
  //   await emit.forEach(
  //     _videoRepository.musicPlayerDataStream,
  //     onData: (data) {
  //       if (state.status == MusicPlayerStatus.initial &&
  //           data.currentAudio == null) {
  //         return state.copyWith(
  //           musicPlayerData: data,
  //           status: MusicPlayerStatus.initial,
  //         );
  //       } else if (state.status == MusicPlayerStatus.initial &&
  //           data.currentAudio != null) {
  //         return state.copyWith(
  //           musicPlayerData: data,
  //           status: MusicPlayerStatus.loaded,
  //         );
  //       } else if (state.status == MusicPlayerStatus.paused) {
  //         return state.copyWith(
  //           musicPlayerData: data,
  //           status: MusicPlayerStatus.paused,
  //         );
  //       } else if (state.status == MusicPlayerStatus.playing) {
  //         return state.copyWith(
  //           musicPlayerData: data,
  //           status: MusicPlayerStatus.playing,
  //         );
  //       } else {
  //         return state.copyWith(
  //           musicPlayerData: data,
  //           status: MusicPlayerStatus.initial,
  //         );
  //       }
  //     },
  //   );
  // }

  // void _onPlay(
  //     VideoPlayerPlay event,
  //     Emitter<VideoPlayerState> emit,
  //     ) async {
  //   _videoRepository.play();
  //   emit(state.copyWith(status: VideoPlayerStatus.playing));
  // }
  //
  // void _onPause(
  //     MusicPlayerPause event,
  //     Emitter<MusicPlayerState> emit,
  //     ) async {
  //   _songRepository.pause();
  //   emit(state.copyWith(status: MusicPlayerStatus.paused));
  // }
  //
  void _onPrev(
      VideoPlayerPrev event,
      Emitter<VideoPlayerState> emit,
      ) async {
    _videoRepository.skipToNextVideo();
    emit(state.copyWith(status: VideoPlayerStatus.playing));
  }

  void _onNext(
      VideoPlayerNext event,
      Emitter<VideoPlayerState> emit,
      ) async {
    _videoRepository.skipToPreviousVideo();
    emit(state.copyWith(status: VideoPlayerStatus.playing));
  }
  //
  // void _onSeek(
  //     MusicPlayerSeek event,
  //     Emitter<MusicPlayerState> emit,
  //     ) async {
  //   _songRepository.seek(event.position);
  //   emit(state.copyWith(status: MusicPlayerStatus.playing));
  // }
  //
  // void _onSetCurrentSong(
  //     MusicPlayerSetCurrentSong event,
  //     Emitter<MusicPlayerState> emit,
  //     ) async {
  //   await _songRepository.setCurrentSong(event.song);
  //   emit(state.copyWith(status: MusicPlayerStatus.initial));
  // }
  //
  // void _onSetCurrentQueue(
  //     MusicPlayerSetCurrentQueue event,
  //     Emitter<MusicPlayerState> emit,
  //     ) async {
  //   await _songRepository.setCurrentQueue(event.song);
  //   emit(state.copyWith(status: MusicPlayerStatus.initial));
  // }
  //
  // void _onAddSong(
  //     MusicPlayerAddSong event,
  //     Emitter<MusicPlayerState> emit,
  //     ) async {
  //   await _songRepository.addSong(event.song);
  //   emit(state.copyWith(status: MusicPlayerStatus.initial));
  // }
}
