import 'package:audio_service/audio_service.dart';
import 'package:e_learning/features/audiobook/bloc/audio_details/audio_details_bloc.dart';
import 'package:e_learning/features/audiobook/domain/models/audio_details/audio_details_data.dart';
import 'package:e_learning/features/audiobook/domain/models/music_player/music_player_data.dart';
import 'package:rxdart/rxdart.dart';

class SongRepository {
  SongRepository({required AudioHandler audioHandler, required this.data})
      : _audioHandler = audioHandler;

  final AudioHandler _audioHandler;

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

  void play() => _audioHandler.play();

  void pause() => _audioHandler.pause();

  /// A stream reporting the combined state of the current media item and its
  /// current position.
  Stream<MusicPlayerData> get musicPlayerDataStream => Rx.combineLatest4<
      PlaybackState,
      List<MediaItem>,
      MediaItem?,
      Duration,
      MusicPlayerData>(_audioHandler.playbackState, _audioHandler.queue,
      _audioHandler.mediaItem, AudioService.position, (
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
    _audioHandler.removeQueueItemAt(0);
    _audioHandler.addQueueItem(song.toMediaItem());
  }
}
