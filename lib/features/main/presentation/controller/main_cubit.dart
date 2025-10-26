import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/firebase/firebase_auth_service.dart';
import '../../../../core/firebase/firestore_service.dart';
import 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit(this._authService, this._firestoreService) : super(MainInitial());

  final List<Widget> screens = <Widget>[
    Center(child: Text('Home Page')),
    Center(child: Text('Search Page')),
    Center(child: Text('Favorites Page')),
    Center(child: Text('Profile Page')),
  ];

  final List<String> icons = <String>[
    AssetsManager.homeIcon,
    AssetsManager.searchIcon,
    AssetsManager.favoritesIcon,
    AssetsManager.profileIcon,
  ];

  final List<String> labels = <String>[
    'Home',
    'Search',
    'favorites',
    'Profile',
  ];
  final FirebaseAuthService _authService;
  final FirestoreService _firestoreService;

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
