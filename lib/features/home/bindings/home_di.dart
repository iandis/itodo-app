import 'package:auth/auth.dart';
import 'package:get_it/get_it.dart';

import '../presentation/blocs/home_bloc.dart';

void initHomeDI() {
  final GetIt getIt = GetIt.I;

  getIt.registerFactory<HomeBloc>(
    () => HomeBloc(
      authRepository: getIt<AuthRepository>(),
    ),
  );
}
