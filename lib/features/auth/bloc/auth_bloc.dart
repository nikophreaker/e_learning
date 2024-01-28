import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:e_learning/core/constants/enums/auth_enums.dart';
import 'package:e_learning/core/init/cache/auth_cache_manager.dart';
import 'package:e_learning/features/auth/domain/services/interface_auth_service.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';

part 'auth_state.dart';

@singleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthService authService;
  final AuthCacheManager authCacheManager;

  AuthBloc(this.authService, this.authCacheManager)
      : super(const AuthState.unknown()) {
    on<AppStarted>((event, emit) async {
      try {
        if (await authCacheManager.isLoggedIn()) {
          await authCacheManager.updateTokenFromStorage();
          emit(const AuthState.onLoginSuccess());
        } else {
          emit((await authCacheManager.isFirstEntry())
              ? const AuthState.firstEntry()
              : const AuthState.guest());
        }
      } on SocketException {
        emit(const AuthState.onLoginError(error: AuthError.hostUnreachable));
      } catch (e) {
        log(e.toString());
        emit(const AuthState.onLoginError());
      }
    });

    on<LoginRequested>(
      (event, emit) async {
        emit(const AuthState.onLoginLoading());
        final String? response = await authService.login(
            email: event.email, password: event.password);
        if (response != null) {
          await authCacheManager.updateToken(response);
          await authCacheManager.updateLoggedIn(true);
          await authCacheManager.updateFirstEntry();
          emit(const AuthState.onLoginSuccess());
        } else {
          // add(LogoutRequested());
          emit(const AuthState.onLoginError(error: AuthError.wrongEmailOrPassword));
        }
      },
    );

    on<LogoutRequested>((event, emit) async {
      try {
        await authCacheManager.signOut();
        emit(const AuthState.guest());
      } catch (_) {}
    });
  }
}
