import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
FutureOr<void> configureDependencies() => getIt.init();

@module
abstract class RegisterModule {
  @singleton
  Dio get dio => Dio();
}

// class GlobalBlocProviders extends StatelessWidget {
//   final Widget child;
//
//   const GlobalBlocProviders({
//     super.key,
//     required this.child,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<OnboardingBloc>(
//           create: (context) => getIt.get<OnboardingBloc>(),
//         ),
//       ],
//       child: child,
//     );
//   }
// }