import 'package:e_learning/core/utils/navigate_util.dart';
import 'package:e_learning/features/courses/bloc/chapter/chapter_bloc.dart';
import 'package:e_learning/features/courses/ui/screens/video_details.dart';
import 'package:flutter/material.dart';

class ChapterWidget extends StatelessWidget {
  const ChapterWidget(
      {super.key,
      required this.chapterData,
      required this.selectedTabbar,
      required this.tapBar,
      required this.textBar,
      required this.openClose,
      required this.isOpen});

  final ChapterFetchingSuccess chapterData;
  final int selectedTabbar;
  final Function(int) tapBar;
  final Function(int, bool) openClose;
  final List<bool> isOpen;
  final List<String> textBar;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey.shade800,
            dividerColor: Colors.grey.shade800,
            dividerHeight: 10,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.grey.shade800),
            tabs: textBar
                .map(
                  (e) => Tab(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: DefaultTextStyle(
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          child: Text(e),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
            onTap: tapBar,
          ),
          Builder(builder: (_) {
            if (selectedTabbar == 0) {
              return Container(
                color: Colors.black,
                child: Center(child: Text("Overview")),
              );
            } else if (selectedTabbar == 1) {
              return ExpansionPanelList(
                materialGapSize: 0,
                expansionCallback: openClose,
                children: List.generate(
                  chapterData.chapterData.length,
                  (i) => ExpansionPanel(
                    canTapOnHeader: true,
                    backgroundColor:
                        i % 2 == 0 ? Colors.black : Colors.grey.shade800,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DefaultTextStyle(
                                  style: const TextStyle(
                                    fontFamily: 'HindGuntur',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                  child: Text("Chapter ${i + 1}"),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: DefaultTextStyle(
                                    style: const TextStyle(
                                      fontFamily: 'HindGuntur',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                    child: Text(
                                        "${chapterData.chapterData[i]?.lesson?.length ?? ""} Lesson • 18 min"),
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: DefaultTextStyle(
                                style: const TextStyle(
                                  fontFamily: 'HindGuntur',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                                child: Text(
                                    chapterData.chapterData[i]?.title ?? ""),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    body: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        children: List.generate(
                          chapterData.chapterData[i]?.lesson?.length ?? 0,
                          (index) => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                              padding: const EdgeInsets.only(bottom: 8.0),
                              foregroundColor: Colors.transparent,
                              shadowColor: Colors.transparent
                            ),
                            onPressed: () {
                              NavigateUtil().navigateToView(context, VideoDetails(lessonId: chapterData.chapterData[i]?.lesson?[index].id ?? ""));
                            },
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 8.0),
                                            child: Image.asset(
                                                "asset/image/lesson.png"),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              DefaultTextStyle(
                                                style: const TextStyle(
                                                  fontFamily: 'HindGuntur',
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.white,
                                                ),
                                                child:
                                                    Text("Lesson ${index + 1}"),
                                              ),
                                              DefaultTextStyle(
                                                style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                                child: Text(chapterData
                                                        .chapterData[i]
                                                        ?.lesson?[index]
                                                        .title ??
                                                    ""),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Image.asset(
                                          "asset/image/play_15px.png"),
                                    ),
                                  ],
                                ),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: DefaultTextStyle(
                                    style: TextStyle(
                                      fontFamily: 'HindGuntur',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white,
                                    ),
                                    child: Text("14 mins"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    isExpanded: !isOpen[i],
                  ),
                ),
              );
            } else {
              return Text("More Like This");
            }
          }),
        ],
      ),
    );
  }
}

class TopCardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    // path.moveTo(0, cornerRadius);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);

    path.lineTo(size.width, 0);

    ///
    path.lineTo(size.width * (1 / 1.5), 0);

    path.cubicTo(size.width * (1 / 1.5), 0, size.width * (1 / 1.6), 0,
        size.width * (1 / 1.7), 20);

    path.lineTo(size.width * (1 / 1.8), 20);

    ///
    path.lineTo(size.width * (1 / 2.3), 20);

    path.cubicTo(size.width * (1 / 2.5), 2, size.width * (1 / 2.6), 2,
        size.width * (1 / 2.7), 0);

    path.lineTo(size.width * (1 / 2.8), 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
