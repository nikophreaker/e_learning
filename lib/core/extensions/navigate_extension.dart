import 'package:e_learning/core/constants/enums/auth_enums.dart';
import 'package:e_learning/features/auth/ui/screens/login.dart';
import 'package:e_learning/features/home/ui/screens/home.dart';
import 'package:e_learning/features/onboarding/ui/screens/onboarding.dart';
import 'package:flutter/material.dart';

// extension NavigateExtension on AuthStatus {
//   Widget get firstView {
//     switch (this) {
//       case AuthStatus.authenticated:
//         // return const Home();
//       case AuthStatus.guest:
//         return const Login();
//       case AuthStatus.unknown:
//       /// MARK: It can be IntroView.
//         break;
//     }
//     return const Onboarding();
//   }
// }