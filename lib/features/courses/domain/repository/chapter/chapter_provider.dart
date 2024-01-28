import 'package:e_learning/features/courses/domain/models/chapter/chapter_data.dart';

abstract class ChapterProvider {
  Future<List<ChapterData?>> getChapterById(String id);
}