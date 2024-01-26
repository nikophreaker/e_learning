part of 'course_bloc.dart';

@immutable
abstract class CourseEvent {}

class CourseFetchEvent extends CourseEvent {
  CourseFetchEvent({required this.id});
  final String id;
}
