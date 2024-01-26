import 'package:atomsbox/atomsbox.dart';
import 'package:e_learning/features/audiobook/bloc/music_player/music_player_bloc.dart';
import 'package:e_learning/features/audiobook/domain/models/music_player/music_player_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FullscreenMusic extends StatelessWidget {
  const FullscreenMusic({
    super.key,
    required this.hideFullscreenDragDown,
  });

  final Function(DragUpdateDetails dd) hideFullscreenDragDown;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: GestureDetector(
        onPanUpdate: hideFullscreenDragDown,
        child: Material(
          color: Colors.black,
          child: BlocConsumer<MusicPlayerBloc, MusicPlayerState>(
            listener: (context, state) {
              if (state.status == MusicPlayerStatus.initial) {
                return;
              } else if (state.status == MusicPlayerStatus.loaded) {
                context.read<MusicPlayerBloc>().add(MusicPlayerPlay());
              }
            },
            builder: (context, state) {
              if (state.status == MusicPlayerStatus.initial) {
                return const SizedBox();
              } else {
                MusicPlayerData data = state.musicPlayerData!;
                AudioPlayerState audioPlayerState = AudioPlayerState.stopped;

                if (state.musicPlayerData!.playbackState.playing == true) {
                  audioPlayerState = AudioPlayerState.playing;
                } else if (state.musicPlayerData!.playbackState.playing ==
                    false) {
                  audioPlayerState = AudioPlayerState.paused;
                }

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: AppConstants.sm),
                  child: AppAudioCard(
                    songName: data.currentAudio?.title,
                    artistName: data.currentAudio?.artist,
                    imageUrl: data.currentAudio?.thumbnail?[0].url,
                    songUrl: data.currentAudio?.path?[0].url,
                    audioPlayerState: audioPlayerState,
                    play: () =>
                        context.read<MusicPlayerBloc>().add(MusicPlayerPlay()),
                    pause: () =>
                        context.read<MusicPlayerBloc>().add(MusicPlayerPause()),
                    position: state.musicPlayerData?.currentSongPosition ??
                        Duration.zero,
                    duration: state.musicPlayerData?.currentSongDuration ??
                        Duration.zero,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

