import 'dart:async';

import 'package:e_learning/core/constants/enums/auth_enums.dart';
import 'package:e_learning/core/utils/navigate_util.dart';
import 'package:e_learning/features/auth/bloc/auth_bloc.dart';
import 'package:e_learning/features/auth/ui/screens/login.dart';
import 'package:e_learning/features/home/ui/screens/home.dart';
import 'package:e_learning/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_learning/features/onboarding/ui/widgets/page_item.dart';
import 'package:dots_indicator/dots_indicator.dart';


class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late final AuthBloc authBloc;
  late StreamSubscription authStream;

  @override
  void initState() {
    super.initState();
    authBloc = context.read<AuthBloc>()..add(AppStarted());

    authStream = authBloc.stream.listen((state) {
      if (state.status == AuthStatus.authenticated) {
        NavigateUtil().navigateToViewReplace(context, Home());
      } else if (state.status == AuthStatus.guest) {
        NavigateUtil().navigateToViewReplace(context, Login());
      } else {
        NavigateUtil().navigateToView(context, Onboarding());
      }
    });
  }

  @override
  void dispose() {
    authStream.cancel();
    super.dispose();
  }

  final PageController controller = PageController(initialPage: 0);

  final _totalDots = 3;
  int _currentPosition = 0;

  int _validPosition(int position) {
    if (position >= _totalDots) return 0;
    if (position < 0) return _totalDots - 1;
    return position;
  }

  void _updatePosition(int position) {
    setState(() => _currentPosition = _validPosition(position));
  }

  String getPrettyCurrPosition() {
    return (_currentPosition + 1.0).toStringAsPrecision(3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: PageView(
              controller: controller,
              onPageChanged: (value) {
                _updatePosition(value.round());
              },
              children: [
                PageItem(
                    controller: controller,
                    pageIndex: 0,
                    imageUrl: Assets.assetImageOnboarding1,
                    title: "Upgrade skills, Show off credentials!",
                    desc:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis accumsan."),
                PageItem(
                    controller: controller,
                    pageIndex: 1,
                    imageUrl: Assets.assetImageOnboarding2,
                    title: "Gain Insights and read Trending Articles",
                    desc:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis serun"),
                PageItem(
                    controller: controller,
                    pageIndex: 2,
                    imageUrl: Assets.assetImageOnboarding3,
                    title: "Attend Events and Expand your network!",
                    desc:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis amet"),
              ],
            ),
          ),
          Flexible(
            flex: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DotsIndicator(
                    dotsCount: _totalDots,
                    position: _currentPosition,
                    decorator: const DotsDecorator(
                        color: Colors.grey, activeColor: Colors.red),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 48.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: _currentPosition == 2
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.end,
                children: [
                  Visibility(
                    visible: _currentPosition != 2,
                    // don't show on page with index 2 (last page)
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ),
                                (route) => false);
                      },
                      child: Text(
                        'Skip',
                        textAlign: TextAlign.center,
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleMedium,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _currentPosition == 2
                          ? Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                              (route) => false)
                          : controller.animateToPage(
                          _currentPosition + 1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.decelerate);
                    },
                    child: _currentPosition == 2
                        ? Container(
                      width: 150,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.red.shade800,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        'Get Started',
                        textAlign: TextAlign.center,
                        style:
                        Theme
                            .of(context)
                            .textTheme
                            .titleMedium,
                      ),
                    )
                        : Container(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
