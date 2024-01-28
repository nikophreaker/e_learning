import 'dart:developer';

import 'package:atomsbox/atomsbox.dart';
import 'package:audio_service/audio_service.dart';
import 'package:e_learning/features/audiobook/bloc/audio_details/audio_details_bloc.dart';
import 'package:e_learning/features/audiobook/bloc/music_player/music_player_bloc.dart';
import 'package:e_learning/features/audiobook/domain/models/audio_details/audio_details_data.dart';
import 'package:e_learning/features/audiobook/domain/models/music_player/music_player_data.dart';
import 'package:e_learning/features/audiobook/domain/repository/audio_details/song_repository.dart';
import 'package:e_learning/features/audiobook/ui/widgets/custom_mini_player.dart';
import 'package:e_learning/features/audiobook/ui/widgets/floating_music.dart';
import 'package:e_learning/features/audiobook/ui/widgets/subtitle_widget.dart';
import 'package:e_learning/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniplayer/miniplayer.dart';

class AudioDetails extends StatefulWidget {
  const AudioDetails({super.key});

  @override
  State<AudioDetails> createState() => _AudioDetailsState();
}

class _AudioDetailsState extends State<AudioDetails> {
  final AudioDetailsBloc audioDetailsBloc = getIt.get<AudioDetailsBloc>();

  ValueNotifier<double> xNavbar = ValueNotifier(70);
  MiniplayerController miniplayerController = MiniplayerController();

  @override
  void initState() {
    super.initState();
    audioDetailsBloc
        .add(AudioDetailsFetchEvent(id: "65a4b968918aad8a3560a95c"));
  }

  @override
  void dispose() {
    super.dispose();
    getIt.get<AudioHandler>().stop();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
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
                        audioHandler: getIt.get<AudioHandler>(), data: data),
                    child: BlocProvider(
                        create: (context) => MusicPlayerBloc(
                              songRepository: context.read<SongRepository>(),
                            )..add(MusicPlayerStarted()),
                        child: BlocBuilder<AudioDetailsBloc, AudioDetailsState>(
                          builder: (context, state) {
                            // context
                            //     .read<SongRepository>()
                            //     .setCurrentSong(data.audioDetails!);
                            context
                                .read<SongRepository>()
                                .addSong(data.audioDetails!);
                            // context
                            //     .read<SongRepository>()
                            //     .setCurrentQueue([data.audioDetails!,data.audioDetails!,data.audioDetails!].toList());
                            context.read<SongRepository>().play();
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
                                return Stack(
                                  children: [
                                    SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 150.0),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 10.0),
                                              child: Text(
                                                data.audioDetails?.title ?? "",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
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
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'HindGuntur',
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white,
                                                        ),
                                                        child: Text(data
                                                                .audioDetails
                                                                ?.artist ??
                                                            ""),
                                                      ),
                                                      DefaultTextStyle(
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'HindGuntur',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white,
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16.0),
                                              child: Container(
                                                height: 250,
                                                decoration: const BoxDecoration(
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
                                              padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                  bottom: 8.0,
                                                  left: 16.0,
                                                  right: 16.0),
                                              child: DefaultTextStyle(
                                                style: const TextStyle(
                                                  fontFamily: 'HindGuntur',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
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
                                    CustomMiniPlayer(
                                      backgroundColor: Colors.black,
                                      minHeight: 70,
                                      maxHeight: screenHeight,
                                      builder: (height, percentage) => Center(
                                        child: FloatingMusic(
                                          percentage: percentage,
                                          data: data,
                                          currentAudio: currentAudio,
                                          audioPlayerState: audioPlayerState,
                                          hidePlayer: () {
                                            miniplayerController
                                                .animateToHeight(
                                                    state: PanelState.MIN);
                                          },
                                        ),
                                      ),
                                      valueNotifier: xNavbar,
                                      controller: miniplayerController,
                                    ),
                                  ],
                                );
                              },
                            );
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
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: xNavbar,
        builder: (BuildContext context, double value, Widget? child) =>
            Transform.translate(
          offset: Offset(0, value - 70),
          child: const NavBar(),
        ),
      ),
    );
  }
}

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 35.0),
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
    );
  }
}
