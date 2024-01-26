import 'package:audio_handler/audio_handler.dart';
import 'package:e_learning/features/audiobook/bloc/music_player/music_player_bloc.dart';
import 'package:e_learning/features/audiobook/domain/models/music_player/music_player_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:atomsbox/atomsbox.dart'
    show AppSlider, AudioPlayerState, AppConstants;

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({super.key, this.onTap, this.dense = false});

  final bool dense;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MusicPlayerBloc, MusicPlayerState>(
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
          } else if (state.musicPlayerData!.playbackState.playing == false) {
            audioPlayerState = AudioPlayerState.paused;
          }

          return Material(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: AppConstants.sm),
              // child: SeekBar(
              //   duration: state.musicPlayerData?.currentSongDuration ?? Duration.zero,
              //   position: state.musicPlayerData?.currentSongPosition ?? Duration.zero,
              //   bufferedPosition: Duration.zero,
              // ),
              child: AppSlider(
                height: AppConstants.sm,
                value:
                    (state.musicPlayerData?.currentSongPosition ?? Duration.zero)
                        .inMilliseconds
                        .toDouble(),
                maxValue:
                    (state.musicPlayerData?.currentSongDuration ?? Duration.zero)
                        .inMilliseconds
                        .toDouble(),
                thumbShape: SliderComponentShape.noThumb,
                onChanged: (double) {},
              ),
            ),
          );
        }
      },
    );
  }
}
