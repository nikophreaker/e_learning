import 'package:e_learning/features/audiobook/domain/models/audio_details/audio_details_data.dart';

abstract class AudioDetailsProvider {
  // final DioManager dioManager;
  // AudioDetailsProvider(this.dioManager);

  Future<AudioDetailsData?> getAudioDetails(String id);
}