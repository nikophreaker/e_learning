import 'package:audio_handler/audio_handler.dart';
import 'package:e_learning/core/utils/duration_ext.dart';
import 'package:e_learning/features/audiobook/bloc/music_player/music_player_bloc.dart';
import 'package:e_learning/features/audiobook/domain/models/music_player/music_player_data.dart';
import 'package:e_learning/features/audiobook/ui/widgets/audio_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:atomsbox/atomsbox.dart'
    show AppConstants, AppSlider, AppText, AudioPlayerState;

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({super.key, this.onTap, this.mini = false});

  final bool mini;
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

          final double value =
              (state.musicPlayerData?.currentSongPosition ?? Duration.zero)
                  .inMilliseconds
                  .toDouble();

          final double maxValue =
              (state.musicPlayerData?.currentSongDuration ?? Duration.zero)
                  .inMilliseconds
                  .toDouble();

          final position =
              state.musicPlayerData?.currentSongPosition ?? Duration.zero;
          final duration =
              state.musicPlayerData?.currentSongDuration ?? Duration.zero;

          play() => context.read<MusicPlayerBloc>().add(MusicPlayerPlay());

          pause() => context.read<MusicPlayerBloc>().add(MusicPlayerPause());

          prev() => context.read<MusicPlayerBloc>().add(MusicPlayerPrev());

          next() => context.read<MusicPlayerBloc>().add(MusicPlayerNext());

          seek(Duration position) => context
              .read<MusicPlayerBloc>()
              .add(MusicPlayerSeek(position: position));

          return Column(
            children: [
              SizedBox(
                height: mini ? 2 : 20,
                child: SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: Colors.grey.shade800,
                    thumbColor: Colors.white,
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 5),
                    trackShape: CustomTrackShape(),
                  ),
                  child: Slider(
                    min: 0.0,
                    max: maxValue,
                    value: value,
                    label: value.toString(),
                    allowedInteraction: SliderInteraction.tapAndSlide,
                    onChanged: (dd) {
                      seek(
                        Duration(
                          milliseconds: dd.toInt(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              if (!mini)
                const SizedBox(
                  height: 5,
                ),
              if (!mini)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText.bodySmall(position.formatDuration()),
                    AppText.bodySmall(duration.formatDuration()),
                  ],
                ),
              if (!mini)
                AudioControls(
                  play: play,
                  pause: pause,
                  prev: prev,
                  next: next,
                  audioPlayerState: audioPlayerState,
                  showSecondaryButtons: true,
                )
            ],
          );
        }
      },
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
