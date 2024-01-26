part of 'lesson_bloc.dart';

@immutable
abstract class LessonEvent {}

class LessonFetchEvent extends LessonEvent {
  LessonFetchEvent({required this.id});
  final String id;
}
