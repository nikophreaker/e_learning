import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_learning/features/courses/domain/models/course/course_data.dart';
import 'package:e_learning/features/courses/domain/repository/course/course_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

part 'course_event.dart';

part 'course_state.dart';

@injectable
class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final CourseRepository courseRepository;

  CourseBloc(this.courseRepository) : super(CourseInitial()) {
    on<CourseFetchEvent>(courseFetchEvent);
  }

  FutureOr<void> courseFetchEvent(
      CourseFetchEvent event, Emitter<CourseState> emit) async {
    emit(CourseFetchingLoadingState());
    CourseData? courseData = await courseRepository.getCourseById(event.id);
    emit(CourseFetchingSuccess(courseData: courseData));
  }
}
