import 'dart:async';

import 'package:auth/auth.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const HomeInit()) {
    on<_HomeAuthenticatedEvent>(_onAuthenticated);
    on<_HomeUnauthenticatedEvent>(_onUnauthenticated);
    on<HomeLogoutEvent>(_onLogout);

    _currentSessionSubscription =
        _authRepository.currentSessionChanges().listen(_onSessionChanges);
  }

  final AuthRepository _authRepository;

  late final StreamSubscription<AuthResult?> _currentSessionSubscription;

  void _onSessionChanges(AuthResult? currentSession) {
    if (currentSession != null) {
      add(_HomeAuthenticatedEvent());
    } else {
      add(_HomeUnauthenticatedEvent());
    }
  }

  Future<void> _onLogout(
    HomeLogoutEvent event,
    Emitter<HomeState> emit,
  ) async {
    await _authRepository.signOut();
  }

  void _onAuthenticated(
    _HomeAuthenticatedEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(const HomeAuthenticated());
  }

  void _onUnauthenticated(
    _HomeUnauthenticatedEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(const HomeUnauthenticated());
  }

  @override
  Future<void> close() {
    _currentSessionSubscription.cancel();
    return super.close();
  }
}
