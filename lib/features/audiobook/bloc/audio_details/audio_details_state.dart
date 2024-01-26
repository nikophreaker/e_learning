part of 'audio_details_bloc.dart';

@immutable
abstract class AudioDetailsState {}

class AudioDetailsInitial extends AudioDetailsState {}

class AudioDetailsFetchingLoadingState extends AudioDetailsState {}

class AudioDetailsFetchingErrorState extends AudioDetailsState {}

class AudioDetailsSuccessFetch extends AudioDetailsState {
  final AudioDetailsData? audioDetails;
  AudioDetailsSuccessFetch({required this.audioDetails});
}


