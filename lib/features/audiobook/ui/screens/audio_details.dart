import 'dart:developer';

import 'package:atomsbox/atomsbox.dart';
import 'package:audio_handler/audio_handler.dart';
import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:e_learning/core/init/network/dio_manager.dart';
import 'package:e_learning/features/audiobook/bloc/audio_details/audio_details_bloc.dart';
import 'package:e_learning/features/audiobook/bloc/music_player/music_player_bloc.dart';
import 'package:e_learning/features/audiobook/domain/models/audio_details/audio_details_data.dart';
import 'package:e_learning/features/audiobook/domain/models/music_player/music_player_data.dart';
import 'package:e_learning/features/audiobook/domain/repository/audio_details/audio_details_repo.dart';
import 'package:e_learning/features/audiobook/domain/repository/audio_details/song_repository.dart';
import 'package:e_learning/features/audiobook/ui/widgets/floating_music.dart';
import 'package:e_learning/features/audiobook/ui/widgets/fullscreen_music.dart';
import 'package:e_learning/features/audiobook/ui/widgets/subtitle_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AudioDetails extends StatefulWidget {
  const AudioDetails({super.key, required this.audioHandler});

  final AudioHandler audioHandler;

  @override
  State<AudioDetails> createState() => _AudioDetailsState();
}

class _AudioDetailsState extends State<AudioDetails> {
  final AudioDetailsBloc audioDetailsBloc =
      AudioDetailsBloc(AudioDetailsRepository(DioManager.instance));

  bool showFullscreen = false;

  @override
  void initState() {
    super.initState();
    audioDetailsBloc.add(AudioDetailsFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Center(
        child: BlocConsumer<AudioDetailsBloc, AudioDetailsState>(
          bloc: audioDetailsBloc,
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.runtimeType) {
              case AudioDetailsFetchingLoadingState:
                return const Center(child: CircularProgressIndicator());
              case AudioDetailsSuccessFetch:
                final data = state as AudioDetailsSuccessFetch;
                return RepositoryProvider(
                  create: (context) => SongRepository(
                      audioHandler: widget.audioHandler, data: data),
                  child: BlocProvider(
                      create: (context) => MusicPlayerBloc(
                            songRepository: context.read<SongRepository>(),
                          )..add(MusicPlayerStarted()),
                      child: BlocBuilder<AudioDetailsBloc, AudioDetailsState>(
                        builder: (context, state) {
                          return StreamBuilder(
                              stream: context
                                  .read<SongRepository>()
                                  .musicPlayerDataStream,
                              builder: (context, snapshot) {
                                AudioDetailsData? currentAudio;
                                AudioPlayerState? audioPlayerState;
                                if (snapshot.hasData) {
                                  final musicPlayerData =
                                      snapshot.data as MusicPlayerData;
                                  currentAudio = musicPlayerData.currentAudio;
                                  audioPlayerState =
                                      (musicPlayerData.playbackState.playing ==
                                              true)
                                          ? AudioPlayerState.playing
                                          : AudioPlayerState.paused;
                                }
                                return showFullscreen == false
                                    ? Stack(children: [
                                        SingleChildScrollView(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 150.0),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 12.0,
                                                          left: 16.0,
                                                          right: 16.0),
                                                  child: Text(
                                                    data.audioDetails?.title ??
                                                        "",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 16.0),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 8.0),
                                                        child: Image.asset(
                                                          "asset/image/person.png",
                                                          scale: 0.7,
                                                        ),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          DefaultTextStyle(
                                                            style:
                                                                const TextStyle(
                                                              fontFamily:
                                                                  'HindGuntur',
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            child: Text(data
                                                                    .audioDetails
                                                                    ?.artist ??
                                                                ""),
                                                          ),
                                                          DefaultTextStyle(
                                                            style:
                                                                const TextStyle(
                                                              fontFamily:
                                                                  'HindGuntur',
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            child: Text(data
                                                                    .audioDetails
                                                                    ?.jobTitle ??
                                                                ""),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SubtitleWidget(
                                                  data: data,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 16.0),
                                                  child: Container(
                                                    height: 250,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.grey,
                                                      shape: BoxShape.rectangle,
                                                    ),
                                                    child: SizedBox.expand(
                                                      child: Image.network(data
                                                              .audioDetails
                                                              ?.thumbnail?[0]
                                                              .url ??
                                                          ""),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0,
                                                          bottom: 8.0,
                                                          left: 16.0,
                                                          right: 16.0),
                                                  child: DefaultTextStyle(
                                                    style: const TextStyle(
                                                      fontFamily: 'HindGuntur',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white,
                                                    ),
                                                    child: Text(
                                                        "${data.audioDetails?.description}"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        FloatingMusic(
                                          data: data,
                                          currentAudio: currentAudio,
                                          audioPlayerState: audioPlayerState,
                                          showFullscreen: () {
                                            setState(() {
                                              showFullscreen = !showFullscreen;
                                            });
                                          },
                                        ),
                                      ])
                                    : FullscreenMusic(
                                        hideFullscreenDragDown: (dd) {
                                          if (dd.delta.dy > 1) {
                                            setState(() {
                                              showFullscreen = !showFullscreen;
                                            });
                                          }
                                        },
                                      );
                              });
                        },
                      )),
                );
              case AudioDetailsFetchingErrorState:
                return Text(
                  "ERROR",
                  style: Theme.of(context).textTheme.titleMedium,
                );
              default:
                return Text(
                  "NOTHING",
                  style: Theme.of(context).textTheme.titleMedium,
                );
            }
          },
        ),
      ),
    );
  }
}
