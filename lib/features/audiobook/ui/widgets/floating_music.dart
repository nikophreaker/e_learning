import 'dart:math';

import 'package:atomsbox/atomsbox.dart';
import 'package:e_learning/features/audiobook/bloc/audio_details/audio_details_bloc.dart';
import 'package:e_learning/features/audiobook/domain/models/audio_details/audio_details_data.dart';
import 'package:e_learning/features/audiobook/domain/repository/audio_details/song_repository.dart';
import 'package:e_learning/features/audiobook/ui/widgets/music_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:miniplayer/miniplayer.dart';

class FloatingMusic extends StatelessWidget {
  const FloatingMusic({
    super.key,
    required this.percentage,
    required this.data,
    required this.currentAudio,
    required this.audioPlayerState,
    required this.hidePlayer,
  });

  final double percentage;
  final AudioDetailsSuccessFetch data;
  final AudioDetailsData? currentAudio;
  final AudioPlayerState? audioPlayerState;
  final Function() hidePlayer;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: percentage >= 0.03 ? Colors.black : Colors.grey.shade900,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 9.0),
        child: Column(children: [
          Visibility(
            visible: percentage >= 0.26,
            child: Opacity(
              opacity: percentage <= 0.26 ? 0 : percentage,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: hidePlayer,
                    icon: Image.asset("asset/image/down.png"),
                  ),
                  const Column(
                    children: [
                      DefaultTextStyle(
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        child: Text(
                          "PLAYING FROM SEARCH",
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      DefaultTextStyle(
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        child: Text(
                          "“UX” in Search",
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset("asset/image/burger.png"),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.translate(
                offset: percentage >= 0 && percentage <= 0.5
                    ? Offset((screenWidth / 2 - 35) * percentage,
                        (screenHeight / 2 - 35) * percentage)
                    : Offset((screenWidth / 12 - 35) * percentage,
                        (screenHeight / 4 - 35) * percentage),
                child: Transform.scale(
                  scale: percentage >= 0 && percentage <= 0.5
                      ? percentage + 1
                      : (percentage + 1) * 4,
                  child: SizedBox(
                    height: (percentage + (percentage <= 0.5 ? 0.9 : 0.5)) * 35,
                    child: AspectRatio(
                      aspectRatio: percentage <= 0.5 ? 35 / 35 : 343 / 400,
                      child: Image.network(
                        data.audioDetails?.thumbnail?[0].url ??
                            "asset/image/person.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: percentage >= 0 && percentage <= 0.4,
                child: Opacity(
                  opacity: percentage >= 0.2 ? 0 : 1 - (percentage * 2),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: screenWidth * (58 / 100),
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
                                    (data.audioDetails?.title ?? "") +
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
                          Row(
                            children: [
                              IconButton(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
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
                                  if (data.audioDetails!.id ==
                                          currentAudio?.id &&
                                      audioPlayerState ==
                                          AudioPlayerState.playing) {
                                    context.read<SongRepository>().pause();
                                  } else if (currentAudio == null &&
                                      audioPlayerState ==
                                          AudioPlayerState.paused) {
                                    context.read<SongRepository>().play();
                                  } else {
                                    context.read<SongRepository>().play();
                                  }
                                },
                                icon: Image.asset(
                                  audioPlayerState == AudioPlayerState.playing
                                      ? "asset/image/pause_15px.png"
                                      : "asset/image/play_15px.png",
                                  scale: 0.9,
                                ),
                              ),
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible: percentage >= 0.5,
            child: SizedBox(
              height: (percentage + (percentage <= 0.5 ? 0.9 : 0.5)) * 250,
            ),
          ),
          Visibility(
            visible: percentage >= 0.9,
            child: Opacity(
              opacity: percentage <= 0.5 ? 0 : percentage,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: screenWidth * (68 / 100),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DefaultTextStyle(
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                  child: Text(
                                    (data.audioDetails?.title ?? "") +
                                        (data.audioDetails?.title ?? ""),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                DefaultTextStyle(
                                  style: const TextStyle(
                                    fontFamily: 'HindGuntur',
                                    fontSize: 18,
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
                          Row(
                            children: [
                              IconButton(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                onPressed: () {},
                                icon: Image.asset(
                                  "asset/image/audio.png",
                                ),
                              ),
                              IconButton(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                onPressed: () {
                                  if (data.audioDetails!.id ==
                                          currentAudio?.id &&
                                      audioPlayerState ==
                                          AudioPlayerState.playing) {
                                    context.read<SongRepository>().pause();
                                  } else if (currentAudio == null &&
                                      audioPlayerState ==
                                          AudioPlayerState.paused) {
                                    context.read<SongRepository>().play();
                                  } else {
                                    context.read<SongRepository>().play();
                                  }
                                },
                                icon: Image.asset(
                                  audioPlayerState == AudioPlayerState.playing
                                      ? "asset/image/pause_15px.png"
                                      : "asset/image/play_15px.png",
                                ),
                              ),
                            ],
                          ),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 20,
                          padding: const EdgeInsets.symmetric(
                              vertical: 1.0, horizontal: 10.0),
                          decoration: BoxDecoration(
                            color: const Color(0xff222326),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "asset/image/tag.png",
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 2.0),
                                child: DefaultTextStyle(
                                  style: TextStyle(
                                    fontFamily: 'HindGuntur',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                  child: Text("Soft SKill"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 5.0, right: 16.0),
                          child: DefaultTextStyle(
                            style: const TextStyle(
                              fontFamily: 'HindGuntur',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                            child: Text(
                              "${DateFormat('MMMd', 'en_US').format(DateTime.parse(data.audioDetails!.createdAt.toString())).toString()} • in ${data.audioDetails?.languange}",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: MusicPlayer(
                      mini: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: percentage >= 0 && percentage <= 0.5,
            child: Opacity(
              opacity: percentage >= 0.2 ? 0 : 1 - (percentage * 2),
              child: const MusicPlayer(
                mini: true,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
