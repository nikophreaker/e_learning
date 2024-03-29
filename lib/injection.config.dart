// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:audio_service/audio_service.dart' as _i3;
import 'package:dio/dio.dart' as _i4;
import 'package:e_learning/core/init/cache/auth_cache_manager.dart' as _i9;
import 'package:e_learning/features/audiobook/bloc/audio_details/audio_details_bloc.dart'
    as _i13;
import 'package:e_learning/features/audiobook/domain/repository/audio_details/audio_details_repo.dart'
    as _i8;
import 'package:e_learning/features/auth/bloc/auth_bloc.dart' as _i14;
import 'package:e_learning/features/auth/domain/services/auth_service.dart'
    as _i6;
import 'package:e_learning/features/auth/domain/services/interface_auth_service.dart'
    as _i5;
import 'package:e_learning/features/courses/bloc/chapter/chapter_bloc.dart'
    as _i15;
import 'package:e_learning/features/courses/bloc/course/course_bloc.dart'
    as _i16;
import 'package:e_learning/features/courses/bloc/lesson/lesson_bloc.dart'
    as _i12;
import 'package:e_learning/features/courses/domain/repository/chapter/chapter_repo.dart'
    as _i10;
import 'package:e_learning/features/courses/domain/repository/course/course_repo.dart'
    as _i11;
import 'package:e_learning/features/courses/domain/repository/lesson/lesson_repo.dart'
    as _i7;
import 'package:e_learning/injection.dart' as _i17;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.singletonAsync<_i3.AudioHandler>(() => registerModule.audioHandler);
    gh.singleton<_i4.Dio>(registerModule.dio);
    gh.factory<_i5.IAuthService>(() => _i6.AuthService(gh<_i4.Dio>()));
    gh.factory<_i7.LessonRepository>(() => _i7.LessonRepository(gh<_i4.Dio>()));
    gh.factory<_i8.AudioDetailsRepository>(
        () => _i8.AudioDetailsRepository(gh<_i4.Dio>()));
    gh.singleton<_i9.AuthCacheManager>(_i9.AuthCacheManager(gh<_i4.Dio>()));
    gh.factory<_i10.ChapterRepository>(
        () => _i10.ChapterRepository(gh<_i4.Dio>()));
    gh.factory<_i11.CourseRepository>(
        () => _i11.CourseRepository(gh<_i4.Dio>()));
    gh.factory<_i12.LessonBloc>(
        () => _i12.LessonBloc(gh<_i7.LessonRepository>()));
    gh.factory<_i13.AudioDetailsBloc>(
        () => _i13.AudioDetailsBloc(gh<_i8.AudioDetailsRepository>()));
    gh.singleton<_i14.AuthBloc>(_i14.AuthBloc(
      gh<_i5.IAuthService>(),
      gh<_i9.AuthCacheManager>(),
    ));
    gh.factory<_i15.ChapterBloc>(
        () => _i15.ChapterBloc(gh<_i10.ChapterRepository>()));
    gh.factory<_i16.CourseBloc>(
        () => _i16.CourseBloc(gh<_i11.CourseRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i17.RegisterModule {}
