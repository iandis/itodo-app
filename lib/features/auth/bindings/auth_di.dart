import 'package:auth/auth.dart';
import 'package:config/config.dart';
import 'package:get_it/get_it.dart';
import 'package:network/network.dart';
import 'package:user/user.dart';

import '../config/auth_token.dart';
import '../login/presentation/blocs/login_bloc.dart';

void initAuthDI() {
  final GetIt getIt = GetIt.I;

  getIt
    ..registerLazySingleton<AuthRepository>(AuthRepository.create)
    ..registerLazySingleton<AuthToken>(
      () => AuthToken(
        authRepository: getIt<AuthRepository>(),
      ),
    )
    ..registerLazySingleton<GQLClient>(
      () => GQLClient(
        baseUrl: Config.baseUrl,
        auth: getIt<AuthToken>(),
      ),
    )
    ..registerLazySingleton<UserRepository>(
      () => UserRepository.create(getIt<GQLClient>()),
    )
    ..registerFactory<LoginBloc>(
      () => LoginBloc(
        authRepository: getIt<AuthRepository>(),
        userRepository: getIt<UserRepository>(),
      ),
    );
}
