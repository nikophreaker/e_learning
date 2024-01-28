import 'package:e_learning/features/courses/domain/models/lesson/lesson_data.dart';

abstract class LessonProvider {
  Future<List<LessonData?>> getLessonById(String id);
}