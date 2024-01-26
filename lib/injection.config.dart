// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:e_learning/core/init/cache/auth_cache_manager.dart' as _i7;
import 'package:e_learning/features/audiobook/bloc/audio_details/audio_details_bloc.dart'
    as _i8;
import 'package:e_learning/features/audiobook/domain/repository/audio_details/audio_details_repo.dart'
    as _i6;
import 'package:e_learning/features/auth/bloc/auth_bloc.dart' as _i9;
import 'package:e_learning/features/auth/domain/services/auth_service.dart'
    as _i5;
import 'package:e_learning/features/auth/domain/services/interface_auth_service.dart'
    as _i4;
import 'package:e_learning/injection.dart' as _i10;
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
    gh.singleton<_i3.Dio>(registerModule.dio);
    gh.factory<_i4.IAuthService>(() => _i5.AuthService(gh<_i3.Dio>()));
    gh.factory<_i6.AudioDetailsRepository>(
        () => _i6.AudioDetailsRepository(gh<_i3.Dio>()));
    gh.singleton<_i7.AuthCacheManager>(_i7.AuthCacheManager(gh<_i3.Dio>()));
    gh.factory<_i8.AudioDetailsBloc>(
        () => _i8.AudioDetailsBloc(gh<_i6.AudioDetailsRepository>()));
    gh.singleton<_i9.AuthBloc>(_i9.AuthBloc(
      gh<_i4.IAuthService>(),
      gh<_i7.AuthCacheManager>(),
    ));
    return this;
  }
}

class _$RegisterModule extends _i10.RegisterModule {}
