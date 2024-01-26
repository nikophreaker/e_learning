import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:e_learning/core/constants/enums/auth_enums.dart';
import 'package:e_learning/core/constants/enums/network_enums.dart';
import 'package:e_learning/core/init/cache/cache_manager.dart';
import 'package:e_learning/core/utils/navigate_util.dart';
import 'package:e_learning/features/audiobook/ui/screens/audio_details.dart';
import 'package:e_learning/features/auth/bloc/auth_bloc.dart';
import 'package:e_learning/features/auth/ui/screens/login.dart';
import 'package:e_learning/features/onboarding/ui/screens/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.audioHandler});

  final AudioHandler audioHandler;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<String?> token =
      Future.value(CacheManager.getString(NetworkEnums.token.path));

  late final AuthBloc authBloc;
  late StreamSubscription authStream;

  @override
  void initState() {
    super.initState();
    authBloc = context.read<AuthBloc>();
    authStream = authBloc.stream.listen((state) {
      if (state.status == AuthStatus.authenticated) {
        NavigateUtil().navigateToViewReplace(context, Home(audioHandler: widget.audioHandler));
      } else if (state.status == AuthStatus.guest) {
        NavigateUtil().navigateToViewReplace(context, Login(audioHandler: widget.audioHandler));
      } else {
        NavigateUtil().navigateToView(context, Onboarding(audioHandler: widget.audioHandler));
      }
    });
  }

  @override
  void dispose() {
    authStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
        future: token,
        builder: (context, AsyncSnapshot<String?> snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                snapshot.hasData ? "Token ${snapshot.data}" : "Guest",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AudioDetails(
                        audioHandler: widget.audioHandler,
                      ),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                    backgroundColor: Colors.red.shade800,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
                child: Text(
                  "Audio Details",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                    backgroundColor: Colors.red.shade800,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
                child: Text(
                  "Course Details",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              TextButton(
                onPressed: () {
                  if (snapshot.hasData) {
                    context.read<AuthBloc>().add(LogoutRequested());
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                style: TextButton.styleFrom(
                    backgroundColor: Colors.red.shade800,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
                child: Text(
                  snapshot.hasData ? "Logout" : "Login",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              )
            ],
          );
        });
  }
}
