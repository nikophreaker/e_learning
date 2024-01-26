part of 'lesson_bloc.dart';

@immutable
abstract class LessonState {}

class LessonInitial extends LessonState {}

class LessonFetchingLoadingState extends LessonState {}

class LessonFetchingErrorState extends LessonState {}

class LessonFetchingSuccess extends LessonState {
  final LessonData? lessonData;
  LessonFetchingSuccess({required this.lessonData});
}
