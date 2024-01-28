part of 'chapter_bloc.dart';

@immutable
abstract class ChapterState {}

class ChapterInitial extends ChapterState {}

class ChapterFetchingLoadingState extends ChapterState {}

class ChapterFetchingErrorState extends ChapterState {}

class ChapterFetchingSuccess extends ChapterState {
  final List<ChapterData?> chapterData;
  ChapterFetchingSuccess({required this.chapterData});
}
