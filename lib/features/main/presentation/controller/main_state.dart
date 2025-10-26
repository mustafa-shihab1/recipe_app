
abstract class MainState {}

class MainInitial extends MainState {}

class MainTabChangedState extends MainState {
  final int currentIndex;

  MainTabChangedState (this.currentIndex);
}

