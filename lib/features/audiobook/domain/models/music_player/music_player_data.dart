import 'package:audio_service/audio_service.dart';
import 'package:e_learning/features/audiobook/domain/models/audio_details/audio_details_data.dart';

class MusicPlayerData {
  final AudioDetailsData? currentAudio;
  final List<AudioDetailsData> audioQueue;
  final PlaybackState playbackState;
  final Duration? currentSongDuration;
  final Duration? currentSongPosition;

  MusicPlayerData({
    this.currentAudio,
    required this.audioQueue,
    required this.playbackState,
    this.currentSongDuration,
    this.currentSongPosition,
  });
}