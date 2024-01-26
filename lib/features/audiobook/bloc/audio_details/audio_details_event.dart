part of 'audio_details_bloc.dart';

@immutable
abstract class AudioDetailsEvent {}

class AudioDetailsFetchEvent extends AudioDetailsEvent {
  AudioDetailsFetchEvent({required this.id});
  final String id;
}
