part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInit extends HomeState {
  const HomeInit();
}

class HomeAuthenticated extends HomeState {
  const HomeAuthenticated();
}

class HomeUnauthenticated extends HomeState {
  const HomeUnauthenticated();
}
