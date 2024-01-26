import 'package:dio/dio.dart';
import 'package:e_learning/core/init/network/dio_manager.dart';
import 'package:injectable/injectable.dart';

abstract class IAuthService {
  // // final DioManager dioManager;
  //
  // // IAuthService(this.dioManager);
  // @factoryMethod
  // factory IAuthService(Dio dio) = _IAuthService;

  Future<String?> login({
    required String email,
    required String password,
  });
}
