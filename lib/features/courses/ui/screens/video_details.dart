import 'package:e_learning/core/utils/data_manager.dart';
import 'package:e_learning/features/courses/bloc/chapter/chapter_bloc.dart';
import 'package:e_learning/features/courses/bloc/course/course_bloc.dart';
import 'package:e_learning/features/courses/bloc/lesson/lesson_bloc.dart';
import 'package:e_learning/features/courses/bloc/video_player/video_player_bloc.dart';
import 'package:e_learning/features/courses/domain/repository/video_player/video_repository.dart';
import 'package:e_learning/features/courses/ui/widgets/chapter_widget.dart';
import 'package:e_learning/features/courses/ui/widgets/custom_orientation_controls.dart';
import 'package:e_learning/injection.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoDetails extends StatefulWidget {
  const VideoDetails({super.key, required this.lessonId});

  final String lessonId;

  @override
  State<VideoDetails> createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails> {
  late FlickManager flickManager;
  late DataManager dataManager;

  late List<String> urls;

  final CourseBloc courseBloc = getIt.get<CourseBloc>();
  final ChapterBloc chapterBloc = getIt.get<ChapterBloc>();
  final LessonBloc lessonBloc = getIt.get<LessonBloc>();
  int _selectedTabbar = 1;
  final List<String> _textBar = ["Overview", "Contents", "More Like This"];

  @override
  void initState() {
    super.initState();
    courseBloc.add(CourseFetchEvent(id: "65a63753918aad8a3560a98a"));
    chapterBloc.add(ChapterFetchEvent(id: "65a6384e918aad8a3560a98b"));
    lessonBloc.add(LessonFetchEvent(id: widget.lessonId));
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<CourseBloc, CourseState>(
          bloc: courseBloc,
          listener: (context, courseState) {},
          builder: (context, courseState) {
            switch (courseState.runtimeType) {
              case CourseFetchingLoadingState:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case CourseFetchingSuccess:
                final courseData = courseState as CourseFetchingSuccess;
                return BlocConsumer<ChapterBloc, ChapterState>(
                  bloc: chapterBloc,
                  listener: (context, chapterState) {},
                  builder: (context, chapterState) {
                    switch (chapterState.runtimeType) {
                      case ChapterFetchingLoadingState:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case ChapterFetchingSuccess:
                        // final chapterData =
                        //     chapterState as ChapterFetchingSuccess;
                        // List<bool> isOpen =
                        //     chapterData.chapterData.map((e) => false).toList();
                        return BlocConsumer<LessonBloc, LessonState>(
                          bloc: lessonBloc,
                          listener: (context, lessonState) {},
                          builder: (context, lessonState) {
                            switch (lessonState.runtimeType) {
                              case LessonFetchingLoadingState:
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              case LessonFetchingSuccess:
                                const double iconSize = 20;
                                const double fontSize = 12;
                                final lessonData =
                                    lessonState as LessonFetchingSuccess;
                                urls = lessonData.lessonData
                                    .map((e) => e?.path?[0].url ?? "")
                                    .toList();
                                flickManager = FlickManager(
                                  videoPlayerController:
                                      VideoPlayerController.networkUrl(
                                    Uri.parse(urls[0]),
                                  ),
                                  onVideoEnd: () {
                                    dataManager
                                        .skipToNextVideo(Duration(seconds: 5));
                                  },
                                );
                                dataManager = DataManager(
                                    flickManager: flickManager, urls: urls);
                                return SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: FlickVideoPlayer(
                                          flickManager: flickManager,
                                          preferredDeviceOrientationFullscreen: const [
                                            DeviceOrientation.portraitUp,
                                            DeviceOrientation.landscapeLeft,
                                            DeviceOrientation.landscapeRight,
                                          ],
                                          flickVideoWithControls:
                                              FlickVideoWithControls(
                                            controls: CustomOrientationControls(
                                              dataManager: dataManager,
                                            ),
                                          ),
                                          flickVideoWithControlsFullscreen:
                                              FlickVideoWithControls(
                                            videoFit: BoxFit.fitWidth,
                                            controls: CustomOrientationControls(
                                              dataManager: dataManager,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 2.0),
                                                  child: DefaultTextStyle(
                                                    style: const TextStyle(
                                                      fontFamily: 'HindGuntur',
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white,
                                                    ),
                                                    child: Text(
                                                        "Lesson ${dataManager.currentPlaying + 1}"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: DefaultTextStyle(
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                child: Text(
                                                  lessonData
                                                          .lessonData[dataManager
                                                              .currentPlaying]
                                                          ?.title ??
                                                      "",
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    DefaultTextStyle(
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            'HindGuntur',
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.white,
                                                      ),
                                                      child: Text(
                                                          "Created by ${courseData.courseData?.author ?? ""}"),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Image.asset(
                                                            "asset/image/language.png"),
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 2.0,
                                                                  left: 4.0),
                                                          child:
                                                              DefaultTextStyle(
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'HindGuntur',
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            child: Text(
                                                                "in Indonesia"),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // ChapterWidget(
                                      //   chapterData: chapterData,
                                      //   isOpen: isOpen,
                                      //   openClose: (int index, bool isExpanded) {
                                      //     setState(() {
                                      //       isOpen[index] = !isExpanded;
                                      //     });
                                      //   },
                                      //   textBar: _textBar,
                                      //   selectedTabbar: _selectedTabbar,
                                      //   tapBar: (index) {
                                      //     setState(() {
                                      //       _selectedTabbar = index;
                                      //     });
                                      //   },
                                      // ),
                                    ],
                                  ),
                                );
                              case LessonFetchingErrorState:
                                return Text(
                                  "ERROR",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                );
                              default:
                                return Text(
                                  "NOTHING",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                );
                            }
                          },
                        );
                      case ChapterFetchingErrorState:
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
                );
              case CourseFetchingErrorState:
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: SizedBox(
                  height: 55,
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red.shade800,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Continue Last",
                          style: Theme.of(context).textTheme.titleMedium,
                        ), // <-- Text
                        SizedBox(
                          width: 5,
                        ),
                        Image.asset("asset/image/play_15px.png"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
