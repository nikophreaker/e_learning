import 'package:dio/dio.dart';
import 'package:e_learning/features/audiobook/domain/models/audio_details/audio_details_data.dart';
import 'package:e_learning/features/audiobook/domain/repository/audio_details/audio_details_provider.dart';
import 'package:injectable/injectable.dart';

@injectable
class AudioDetailsRepository extends AudioDetailsProvider {
  final Dio dio;
  AudioDetailsRepository(this.dio);

  @override
  Future<AudioDetailsData?> getAudioDetails(String id) async {
    try {
      Response response =
          await dio.get("audio/?id=$id");
      return AudioDetailsData.fromJson(response.data[0]);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
