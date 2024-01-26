import 'package:e_learning/features/courses/domain/models/course/course_data.dart';

abstract class CourseProvider {
  Future<CourseData?> getCourseById(String id);
}