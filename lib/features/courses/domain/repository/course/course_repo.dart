import 'package:dio/dio.dart';
import 'package:e_learning/features/courses/domain/models/course/course_data.dart';
import 'package:e_learning/features/courses/domain/repository/course/course_provider.dart';
import 'package:injectable/injectable.dart';

@injectable
class CourseRepository implements CourseProvider {
  final Dio dio;
  CourseRepository(this.dio);

  @override
  Future<CourseData?> getCourseById(String id) async {
    try {
      Response response = await dio.get("courses/?id=$id&"r"$lookup=*");
      return CourseData.fromJson(response.data[0]);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}