import 'package:e_learning/features/courses/domain/models/lesson/lesson_data.dart';

abstract class LessonProvider {
  Future<LessonData?> getLessonById(String id);
}