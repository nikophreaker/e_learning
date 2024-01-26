import 'package:dio/dio.dart';
import 'package:e_learning/core/constants/enums/network_enums.dart';
import 'package:injectable/injectable.dart';

import 'cache_manager.dart';

@singleton
class AuthCacheManager {
  final Dio dio;
  AuthCacheManager(this.dio);
  Future<bool> isFirstEntry() async {
    return !(await CacheManager.getBool(NetworkEnums.introOff.path) ?? false);
  }

  Future<bool> isLoggedIn() async {
    return (await CacheManager.getBool(NetworkEnums.login.path)) ?? false;
  }

  Future<void> signOut() async {
    await CacheManager.clearAll();
  }

  Future<void> updateFirstEntry() async {
    await CacheManager.setBool(NetworkEnums.introOff.path, true);
  }

  Future<void> updateLoggedIn(bool isLoggedIn) async {
    await CacheManager.setBool(NetworkEnums.login.path, isLoggedIn);
  }

  Future<void> updateToken(String? token) async {
    if (token != null) {
      await CacheManager.setString(NetworkEnums.token.path, token);
      dio.options
          .headers[(MapEntry('Authorization', 'token $token'))];

      /// Actually, we will not need it for this application.
      /// But I've included it here for instructive purposes.
    } else {
      if (await CacheManager.containsKey(NetworkEnums.token.path)) {
        await CacheManager.remove(NetworkEnums.token.path);
        dio.options.headers.clear();
      }
    }
  }

  Future<void> updateTokenFromStorage() async {
    if (await CacheManager.containsKey(NetworkEnums.token.path)) {
      final token = await CacheManager.getString(NetworkEnums.token.path);
      if (token != null) {
        dio.options
            .headers[(MapEntry('Authorization', 'token $token'))];

        /// Actually, we will not need it for this application.
        /// But I've included it here for instructive purposes.
      }
    }
  }
}
