import 'package:dio/dio.dart';
import 'package:e_learning/features/courses/domain/models/chapter/chapter_data.dart';
import 'package:e_learning/features/courses/domain/repository/chapter/chapter_provider.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChapterRepository implements ChapterProvider {
  final Dio dio;
  ChapterRepository(this.dio);

  @override
  Future<List<ChapterData?>> getChapterById(String id) async {
    try {
      Response response = await dio.get("chapter/?id=$id&"r"$lookup=*");
      return chapterDataFromJson(response);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }

  }

}