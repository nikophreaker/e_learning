import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_learning/features/audiobook/domain/models/audio_details/audio_details_data.dart';
import 'package:e_learning/features/audiobook/domain/repository/audio_details/repositories.dart';
import 'package:flutter/cupertino.dart';

part 'audio_details_event.dart';
part 'audio_details_state.dart';

class AudioDetailsBloc extends Bloc<AudioDetailsEvent, AudioDetailsState> {
  final AudioDetailsRepository repository;
  AudioDetailsBloc(this.repository) : super(AudioDetailsInitial()) {
    on<AudioDetailsFetchEvent>(audioDetailsFetchEvent);
  }

  FutureOr<void> audioDetailsFetchEvent(
      AudioDetailsFetchEvent event, Emitter<AudioDetailsState> emit) async {
    emit(AudioDetailsFetchingLoadingState());
    AudioDetailsData? audioDetails =
    await repository.getAudioDetails(event.id);
    emit(AudioDetailsSuccessFetch(audioDetails: audioDetails));
  }
}
