import 'dart:io';

import 'package:dio/dio.dart';
import 'package:e_learning/core/constants/enums/network_enums.dart';
import 'package:e_learning/features/auth/domain/models/login_model.dart';
import 'package:e_learning/features/auth/domain/models/user_model.dart';
import 'package:e_learning/features/auth/domain/services/interface_auth_service.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IAuthService)
class AuthService extends IAuthService {
  // AuthService(super.dioManager);
  final Dio dio;
  AuthService(this.dio);

  @override
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    // var response = await dioManager.dio.post(
    //   NetworkEnums.login.path,
    //   data: LoginModel(
    //     email: email,
    //     password: password,
    //   ).toJson(),
    // );
    var response = await dio.post(
      NetworkEnums.login.path,
      data: LoginModel(
        email: email,
        password: password,
      ).toJson(),
    );

    try {
      if (response.statusCode == HttpStatus.ok) {
        return UserModel.fromJson(response.data).token;
      } else {
        return throw Exception();
      }
    } catch(err) {
      return null;
    }
  }
}