import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_learning/features/courses/domain/models/chapter/chapter_data.dart';
import 'package:e_learning/features/courses/domain/repository/chapter/chapter_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

part 'chapter_event.dart';
part 'chapter_state.dart';

@injectable
class ChapterBloc extends Bloc<ChapterEvent, ChapterState> {
  final ChapterRepository chapterRepository;
  ChapterBloc(this.chapterRepository) : super(ChapterInitial()) {
    on<ChapterFetchEvent>(chapterFetchEvent);
  }

  FutureOr<void> chapterFetchEvent(ChapterFetchEvent event, Emitter<ChapterState> emit) async {
    emit(ChapterFetchingLoadingState());
    List<ChapterData?> chapterData = await chapterRepository.getChapterById(event.id);
    emit(ChapterFetchingSuccess(chapterData: chapterData));
  }
}
