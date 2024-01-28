import 'package:dio/dio.dart';
import 'package:e_learning/features/courses/domain/models/lesson/lesson_data.dart';
import 'package:e_learning/features/courses/domain/repository/lesson/lesson_provider.dart';
import 'package:injectable/injectable.dart';

@injectable
class LessonRepository implements LessonProvider {
  final Dio dio;
  LessonRepository(this.dio);

  @override
  Future<List<LessonData?>> getLessonById(String id) async {
    try {
      Response response = await dio.get("lesson/?id=$id&"r"$lookup=*");
      print(response.toString());
      return lessonDataFromJson(response);
    } catch(error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
  
}