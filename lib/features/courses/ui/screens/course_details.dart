import 'package:e_learning/core/utils/navigate_util.dart';
import 'package:e_learning/features/courses/bloc/chapter/chapter_bloc.dart';
import 'package:e_learning/features/courses/bloc/course/course_bloc.dart';
import 'package:e_learning/features/courses/ui/screens/video_details.dart';
import 'package:e_learning/features/courses/ui/widgets/chapter_widget.dart';
import 'package:e_learning/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseDetails extends StatefulWidget {
  const CourseDetails({super.key});

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  final CourseBloc courseBloc = getIt.get<CourseBloc>();
  final ChapterBloc chapterBloc = getIt.get<ChapterBloc>();
  int _selectedTabbar = 1;
  final List<String> _textBar = ["Overview", "Contents", "More Like This"];

  @override
  void initState() {
    super.initState();
    courseBloc.add(CourseFetchEvent(id: "65a63753918aad8a3560a98a"));
    chapterBloc.add(ChapterFetchEvent(id: "65a6384e918aad8a3560a98b"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CourseBloc, CourseState>(
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
                      final chapterData =
                          chapterState as ChapterFetchingSuccess;
                      List<bool> isOpen =
                          chapterData.chapterData.map((e) => false).toList();
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Image.asset(
                                "asset/image/thumbnail.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                children: [
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
                                        courseData.courseData?.title ?? "",
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Container(
                                          height: 30,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 6.0, horizontal: 10.0),
                                          decoration: BoxDecoration(
                                            color: const Color(0xff222326),
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "asset/image/brain.png",
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0),
                                                child: DefaultTextStyle(
                                                  style: const TextStyle(
                                                    fontFamily: 'HindGuntur',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                  ),
                                                  child: Text(courseData
                                                          .courseData
                                                          ?.category ??
                                                      ""),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          DefaultTextStyle(
                                            style: const TextStyle(
                                              fontFamily: 'HindGuntur',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
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
                                                padding: EdgeInsets.only(
                                                    top: 2.0, left: 4.0),
                                                child: DefaultTextStyle(
                                                  style: TextStyle(
                                                    fontFamily: 'HindGuntur',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                  ),
                                                  child: Text("in Indonesia"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 2.0),
                                        child: DefaultTextStyle(
                                          style: const TextStyle(
                                            fontFamily: 'HindGuntur',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          ),
                                          child: Text(
                                              "${courseData.courseData?.chapter?.length} Chapters • ${chapterData.chapterData.map((e) => e?.lesson?.length).reduce((a, b) => (a ?? 0) + (b ?? 0))} Lesson • 30m 15s Total Length"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            ChapterWidget(
                              chapterData: chapterData,
                              isOpen: isOpen,
                              openClose: (int index, bool isExpanded) {
                                setState(() {
                                  isOpen[index] = !isExpanded;
                                });
                              },
                              textBar: _textBar,
                              selectedTabbar: _selectedTabbar,
                              tapBar: (index) {
                                setState(() {
                                  _selectedTabbar = index;
                                });
                              },
                            ),
                          ],
                        ),
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
                    onPressed: () {
                    },
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
