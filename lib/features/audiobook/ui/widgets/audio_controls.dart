
import 'package:atomsbox/atomsbox.dart';
import 'package:flutter/material.dart';

class AudioControls extends StatelessWidget {
  const AudioControls({
    Key? key,
    required this.play,
    required this.pause,
    required this.prev,
    required this.next,
    required this.audioPlayerState,
    this.showSecondaryButtons = false,
  }) : super(key: key);

  final VoidCallback play;
  final VoidCallback pause;
  final VoidCallback prev;
  final VoidCallback next;
  final AudioPlayerState audioPlayerState;
  final bool showSecondaryButtons;

  @override
  Widget build(BuildContext context) {
    final primaryButton = _buildPrimaryButton(audioPlayerState);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppIconButton(
          onPressed: () {},
          child: Image.asset("asset/image/share.png"),
        ),
        if (showSecondaryButtons)
          AppIconButton(
            onPressed: prev,
            child: Image.asset("asset/image/prev.png"),
          ),
        primaryButton,
        if (showSecondaryButtons)
          AppIconButton(
            onPressed: next,
            child: Image.asset("asset/image/next.png"),
          ),
        AppIconButton(
          onPressed: () {},
          child: Image.asset("asset/image/bookmark.png"),
        ),
      ],
    );
  }

  Widget _buildPrimaryButton(audioPlayerState) {
    switch (audioPlayerState) {
      case AudioPlayerState.buffering:
      case AudioPlayerState.loading:
        return const SizedBox(
          width: 48,
          height: 48,
          child: CircularProgressIndicator(),
        );
      case AudioPlayerState.paused:
        return AppIconButton(
          onPressed: play,
          child: Image.asset("asset/image/play_59px.png"),
        );
      case AudioPlayerState.playing:
        return AppIconButton(
          onPressed: pause,
          child: Image.asset("asset/image/pause_59px.png"),
        );
      default:
        return AppIconButton(
          onPressed: () {},
          child: const Icon(Icons.replay),
        );
    }
  }
}