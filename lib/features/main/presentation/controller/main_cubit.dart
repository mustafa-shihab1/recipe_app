import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../MyRecipes/presentation/view/my_recipes_view.dart';
import '../../../favorites/presentation/view/favorites_view.dart';
import '../../../home/presentation/view/home_view.dart';
import 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  final List<Widget> screens = <Widget>[
    const HomeView(),
    const FavoritesView(),
    const MyRecipesView(),
    const Center(child: Text('Profile Page')),
  ];

  final List<String> icons = <String>[
    AssetsManager.homeIcon,
    AssetsManager.favoritesIcon,
    AssetsManager.savedIcon,
    AssetsManager.profileIcon,
  ];

  final List<String> labels = <String>[
    'Home',
    'Favorites',
    'My Recipes',
    'Profile',
  ];

  void changeBottomNav(int index) {
    emit(MainTabChangedState(index));
  }

  // Future<void> getUserData() async {
  //   emit(UserDataLoadingState());
  //   try {
  //     final user = _authService.currentUser;
  //     if (user != null) {
  //       final userData = await _firestoreService.getUserData(user.uid);
  //       if (userData != null) {
  //         emit(UserDataSuccessState(userData));
  //       } else {
  //         emit( UserDataErrorState('User data not found.'));
  //       }
  //     } else {
  //       emit( UserDataErrorState('No user logged in.'));
  //     }
  //   } catch (e) {
  //     emit(UserDataErrorState(e.toString()));
  //   }
  // }
}
