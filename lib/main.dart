import 'package:audio_service/audio_service.dart';
import 'package:e_learning/core/init/cache/auth_cache_manager.dart';
import 'package:e_learning/core/init/network/dio_manager.dart';
import 'package:e_learning/features/audiobook/bloc/audio_details/audio_details_bloc.dart';
import 'package:e_learning/features/audiobook/domain/repository/audio_details/audio_details_repo.dart';
import 'package:e_learning/features/auth/bloc/auth_bloc.dart';
import 'package:e_learning/features/auth/domain/services/auth_service.dart';
import 'package:e_learning/features/onboarding/ui/screens/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audio_handler/audio_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await configureDependencies();
  AudioHandler audioHandler = await AudioService.init(
    builder: () => MyAudioHandler(),
    config: const AudioServiceConfig(
        // androidNotificationChannelId: 'com.mycompany.myapp.audio',
        // androidNotificationChannelName: 'Audio Service Demo',
        // androidNotificationOngoing: true,
        // androidStopForegroundOnPause: true,
        ),
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(
            AuthService(DioManager.instance),
            AuthCacheManager(),
          ),
        ),
        BlocProvider<AudioDetailsBloc>(
          create: (_) => AudioDetailsBloc(
            AudioDetailsRepository(DioManager.instance),
          ),
        ),
      ],
      child: MyApp(audioHandler: audioHandler),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required AudioHandler audioHandler})
      : _audioHandler = audioHandler;

  final AudioHandler _audioHandler;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Poppins',
        textTheme: Theme.of(context).textTheme.copyWith(
              titleLarge: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              titleMedium: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              titleSmall: const TextStyle(
                fontFamily: 'HindGuntur',
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                height: 1.8,
              ),
              bodyMedium: const TextStyle(
                fontFamily: 'HindGuntur',
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: Colors.white,
                height: 1.8,
              ),
              bodySmall: const TextStyle(
                fontFamily: 'HindGuntur',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
      ),
      home: Onboarding(audioHandler: _audioHandler,),
    );
  }
}
