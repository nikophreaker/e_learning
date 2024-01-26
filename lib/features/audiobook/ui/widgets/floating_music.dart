import 'dart:ffi';

import 'package:atomsbox/atomsbox.dart';
import 'package:e_learning/features/audiobook/bloc/audio_details/audio_details_bloc.dart';
import 'package:e_learning/features/audiobook/domain/models/audio_details/audio_details_data.dart';
import 'package:e_learning/features/audiobook/domain/repository/audio_details/song_repository.dart';
import 'package:e_learning/features/audiobook/ui/widgets/music_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FloatingMusic extends StatelessWidget {
  const FloatingMusic({
    super.key,
    required this.data,
    required this.currentAudio,
    required this.audioPlayerState,
    required this.showFullscreen,
  });

  final AudioDetailsSuccessFetch data;
  final AudioDetailsData? currentAudio;
  final AudioPlayerState? audioPlayerState;
  final Function() showFullscreen;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 160,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: showFullscreen,
              child: SizedBox(
                height: 80,
                child: SizedBox.expand(
                  child: Stack(children: [
                    Container(
                      color: Colors.grey.shade900,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Image.asset(
                                "asset/image/person.png",
                                scale: 0.7,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DefaultTextStyle(
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                    child: Text(
                                      (data.audioDetails?.title ?? ""),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  DefaultTextStyle(
                                    style: const TextStyle(
                                      fontFamily: 'HindGuntur',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                    child: Text(
                                      "${data.audioDetails?.artist ?? ""} • ${data.audioDetails?.jobTitle}",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 16.0),
                              onPressed: () {},
                              icon: Image.asset(
                                "asset/image/audio.png",
                                scale: 0.9,
                              ),
                            ),
                            IconButton(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              onPressed: () {
                                if (data.audioDetails!.id == currentAudio?.id &&
                                    audioPlayerState ==
                                        AudioPlayerState.playing) {
                                  context.read<SongRepository>().pause();
                                } else if (currentAudio == null &&
                                    audioPlayerState ==
                                        AudioPlayerState.paused) {
                                  context
                                      .read<SongRepository>()
                                      .setCurrentSong(data.audioDetails!);
                                  context.read<SongRepository>().play();
                                } else {
                                  context.read<SongRepository>().play();
                                }
                              },
                              icon: Image.asset(
                                "asset/image/play.png",
                                scale: 0.9,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.bottomCenter,
                      child: MusicPlayer(),
                    ),
                  ]),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SizedBox(
                        height: 55,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red.shade800,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            "Bookmark",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton.outlined(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 35.0),
                    style: IconButton.styleFrom(
                        shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                    onPressed: () {},
                    icon: Image.asset(
                      "asset/image/share.png",
                      width: 25,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
