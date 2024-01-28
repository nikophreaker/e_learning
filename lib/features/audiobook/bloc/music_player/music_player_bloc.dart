import 'package:bloc/bloc.dart';
import 'package:e_learning/features/audiobook/domain/models/audio_details/audio_details_data.dart';
import 'package:e_learning/features/audiobook/domain/models/music_player/music_player_data.dart';
import 'package:e_learning/features/audiobook/domain/repository/audio_details/song_repository.dart';
import 'package:equatable/equatable.dart';

import 'music_player_bloc.dart';

part 'music_player_event.dart';

part 'music_player_state.dart';

class MusicPlayerBloc extends Bloc<MusicPlayerEvent, MusicPlayerState> {
  final SongRepository _songRepository;

  MusicPlayerBloc({
    required SongRepository songRepository,
  })  : _songRepository = songRepository,
        super(const MusicPlayerState()) {
    on<MusicPlayerStarted>(_onStarted);
    on<MusicPlayerPlay>(_onPlay);
    on<MusicPlayerPause>(_onPause);
    on<MusicPlayerPrev>(_onPrev);
    on<MusicPlayerNext>(_onNext);
    on<MusicPlayerSeek>(_onSeek);
    on<MusicPlayerSetCurrentSong>(_onSetCurrentSong);
    on<MusicPlayerSetCurrentQueue>(_onSetCurrentQueue);
    on<MusicPlayerAddSong>(_onAddSong);
  }

  void _onStarted(
    MusicPlayerStarted event,
    Emitter<MusicPlayerState> emit,
  ) async {
    await emit.forEach(
      _songRepository.musicPlayerDataStream,
      onData: (data) {
        if (state.status == MusicPlayerStatus.initial &&
            data.currentAudio == null) {
          return state.copyWith(
            musicPlayerData: data,
            status: MusicPlayerStatus.initial,
          );
        } else if (state.status == MusicPlayerStatus.initial &&
            data.currentAudio != null) {
          return state.copyWith(
            musicPlayerData: data,
            status: MusicPlayerStatus.loaded,
          );
        } else if (state.status == MusicPlayerStatus.paused) {
          return state.copyWith(
            musicPlayerData: data,
            status: MusicPlayerStatus.paused,
          );
        } else if (state.status == MusicPlayerStatus.playing) {
          return state.copyWith(
            musicPlayerData: data,
            status: MusicPlayerStatus.playing,
          );
        } else {
          return state.copyWith(
            musicPlayerData: data,
            status: MusicPlayerStatus.initial,
          );
        }
      },
    );
  }

  void _onPlay(
    MusicPlayerPlay event,
    Emitter<MusicPlayerState> emit,
  ) async {
    _songRepository.play();
    emit(state.copyWith(status: MusicPlayerStatus.playing));
  }

  void _onPause(
    MusicPlayerPause event,
    Emitter<MusicPlayerState> emit,
  ) async {
    _songRepository.pause();
    emit(state.copyWith(status: MusicPlayerStatus.paused));
  }

  void _onPrev(
    MusicPlayerPrev event,
    Emitter<MusicPlayerState> emit,
  ) async {
    _songRepository.prev();
    emit(state.copyWith(status: MusicPlayerStatus.playing));
  }

  void _onNext(
    MusicPlayerNext event,
    Emitter<MusicPlayerState> emit,
  ) async {
    _songRepository.next();
    emit(state.copyWith(status: MusicPlayerStatus.playing));
  }

  void _onSeek(
    MusicPlayerSeek event,
    Emitter<MusicPlayerState> emit,
  ) async {
    _songRepository.seek(event.position);
    emit(state.copyWith(status: MusicPlayerStatus.playing));
  }

  void _onSetCurrentSong(
    MusicPlayerSetCurrentSong event,
    Emitter<MusicPlayerState> emit,
  ) async {
    await _songRepository.setCurrentSong(event.song);
    emit(state.copyWith(status: MusicPlayerStatus.initial));
  }

  void _onSetCurrentQueue(
    MusicPlayerSetCurrentQueue event,
    Emitter<MusicPlayerState> emit,
  ) async {
    await _songRepository.setCurrentQueue(event.song);
    emit(state.copyWith(status: MusicPlayerStatus.initial));
  }

  void _onAddSong(
    MusicPlayerAddSong event,
    Emitter<MusicPlayerState> emit,
  ) async {
    await _songRepository.addSong(event.song);
    emit(state.copyWith(status: MusicPlayerStatus.initial));
  }
}
