part of 'course_bloc.dart';

@immutable
abstract class CourseState {}

class CourseInitial extends CourseState {}

class CourseFetchingLoadingState extends CourseState {}

class CourseFetchingErrorState extends CourseState {}

class CourseFetchingSuccess extends CourseState {
  final CourseData? courseData;
  CourseFetchingSuccess({required this.courseData});
}
