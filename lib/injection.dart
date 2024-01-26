import 'dart:async';

import 'package:dio/dio.dart';
import 'package:e_learning/core/constants/app/string_constants.dart';
import 'package:e_learning/core/init/cache/auth_cache_manager.dart';
import 'package:e_learning/features/audiobook/bloc/audio_details/audio_details_bloc.dart';
import 'package:e_learning/features/auth/bloc/auth_bloc.dart';
import 'package:e_learning/features/auth/domain/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
FutureOr<void> configureDependencies() => getIt.init();


@module
abstract class RegisterModule {
  @singleton
  Dio get dio => Dio(
        BaseOptions(
          validateStatus: (_) => true,
          baseUrl: StringConstants.baseUrl,
          followRedirects: true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );
}

class GlobalBlocProviders extends StatelessWidget {
  final Widget child;

  const GlobalBlocProviders({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => getIt.get<AuthBloc>(),
        ),
        BlocProvider<AudioDetailsBloc>(
          create: (_) => getIt.get<AudioDetailsBloc>(),
        ),
      ],
      child: child,
    );
  }
}
