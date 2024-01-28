import 'package:audio_service/audio_service.dart';
import 'package:e_learning/features/audiobook/bloc/audio_details/audio_details_bloc.dart';
import 'package:e_learning/features/audiobook/domain/models/audio_details/audio_details_data.dart';
import 'package:e_learning/features/audiobook/domain/models/music_player/music_player_data.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

class SongRepository {
  SongRepository({required this.audioHandler, required this.data});

  final AudioHandler audioHandler;

  final AudioDetailsSuccessFetch data;

  Future<List<AudioDetailsData>?> getSongs() async {
    try {
      List<AudioDetailsData> songs = await Future.delayed(
        const Duration(seconds: 1),
            () => [data.audioDetails!],
      );

      return songs;
    } catch (_) {
      return null;
    }
  }

  Future<AudioDetailsData?> getSongById(String songId) async {
    try {
      AudioDetailsData? song = await Future.delayed(
        const Duration(seconds: 1),
            () => [data.audioDetails!].where((song) => song.id == songId).first,
      );

      return song;
    } catch (_) {
      return null;
    }
  }

  void play() => audioHandler.play();

  void pause() => audioHandler.pause();

  void prev() => audioHandler.skipToPrevious();

  void next() => audioHandler.skipToNext();

  void seek(Duration position) => audioHandler.seek(position);

  /// A stream reporting the combined state of the current media item and its
  /// current position.
  Stream<MusicPlayerData> get musicPlayerDataStream => Rx.combineLatest4<
      PlaybackState,
      List<MediaItem>,
      MediaItem?,
      Duration,
      MusicPlayerData>(audioHandler.playbackState, audioHandler.queue,
      audioHandler.mediaItem, AudioService.position, (
          PlaybackState playbackState,
          List<MediaItem> queue,
          MediaItem? mediaItem,
          Duration position,
          ) {
        return MusicPlayerData(
          currentAudio:
          (mediaItem == null) ? null : AudioDetailsData.fromMediaItem(mediaItem),
          audioQueue: queue.map((mediaItem) {
            return AudioDetailsData.fromMediaItem(mediaItem);
          }).toList(),
          playbackState: playbackState,
          currentSongPosition: position,
          currentSongDuration: (mediaItem == null) ? null : mediaItem.duration,
        );
      });

  Future<void> setCurrentSong(AudioDetailsData song) async {
    audioHandler.removeQueueItemAt(0);
    audioHandler.addQueueItem(song.toMediaItem());
  }

  Future<void> setCurrentQueue(List<AudioDetailsData> song) async {
    audioHandler.updateQueue(song.map((e) => e.toMediaItem()).toList());
  }

  Future<void> addSong(AudioDetailsData song) async {
    audioHandler.addQueueItem(song.toMediaItem());
  }
}
