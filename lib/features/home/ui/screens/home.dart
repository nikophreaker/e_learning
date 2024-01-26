import 'package:audio_service/audio_service.dart';
import 'package:e_learning/core/constants/enums/network_enums.dart';
import 'package:e_learning/core/init/cache/cache_manager.dart';
import 'package:e_learning/core/utils/navigate_util.dart';
import 'package:e_learning/features/audiobook/ui/screens/audio_details.dart';
import 'package:e_learning/features/auth/bloc/auth_bloc.dart';
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
        future: token,
        builder: (context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Token ${snapshot.data}",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AudioDetails(audioHandler: widget.audioHandler,),
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
                    context.read<AuthBloc>().add(LogoutRequested());
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.red.shade800,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                  child: Text(
                    "Logout",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                )
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
