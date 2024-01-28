import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_learning/features/courses/domain/models/lesson/lesson_data.dart';
import 'package:e_learning/features/courses/domain/repository/lesson/lesson_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

part 'lesson_event.dart';

part 'lesson_state.dart';

@injectable
class LessonBloc extends Bloc<LessonEvent, LessonState> {
  final LessonRepository lessonRepository;

  LessonBloc(this.lessonRepository) : super(LessonInitial()) {
    on<LessonFetchEvent>(lessonFetchEvent);
  }

  FutureOr<void> lessonFetchEvent(
      LessonFetchEvent event, Emitter<LessonState> emit) async {
    emit(LessonFetchingLoadingState());
    List<LessonData?> lessonData = await lessonRepository.getLessonById(event.id);
    emit(LessonFetchingSuccess(lessonData: lessonData));
  }
}
