part of 'chapter_bloc.dart';

@immutable
abstract class ChapterEvent {}

class ChapterFetchEvent extends ChapterEvent {
  ChapterFetchEvent({required this.id});
  final String id;
}
