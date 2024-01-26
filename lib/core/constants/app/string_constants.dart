import 'package:flutter/material.dart';

@immutable
class StringConstants {
  const StringConstants._();

  static const String appName = 'Bloc Auth';
  static const String baseUrl = 'https://api.kontenbase.com/query/api/v1/2810aabc-9dc5-4d37-8ff1-fd579e9d6f0c/';

  /// for Login view
  static const String loginTitle = "You can log in with your information.";
  static const String loginButtonText = "LOGIN";
  static const String emailTitle = "Email";
  static const String passwordTitle = "Password";
  static const String emailHint = 'example@gmail.com';
  static const String passwordHint = '···········';

  /// for Home view
  static const String homePage = 'Home Page';

  /// for validators
  static const String requiredField = "Required field";
  static const String makeSureCorrectMail =
      "Please Enter the correct email.";
}
