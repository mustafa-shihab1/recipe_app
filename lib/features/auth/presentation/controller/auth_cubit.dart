import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/firebase/firebase_auth_service.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuthService _authService;
  late StreamSubscription<User?> _authSubscription;

  AuthCubit(this._authService) : super(AuthInitialState()) {
    _authSubscription = _authService.authStateChanges.listen((user) {
      if (user != null) {
        emit(AuthSuccessState(user));
      } else {
        emit(Unauthenticated());
      }
    });
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoadingState());
    try {
      await _authService.login(
        email: email,
        password: password,
      );
      // The stream listener will automatically emit AuthSuccessState
    } on Exception catch (e) {
      emit(AuthErrorState(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (password != confirmPassword) {
      emit(AuthErrorState("Passwords do not match."));
      return;
    }
    emit(AuthLoadingState());
    try {
      await _authService.register(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );
      // The stream listener will automatically emit AuthSuccessState
    } on Exception catch (e) {
      emit(AuthErrorState(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> logout() async {
    emit(AuthLoadingState());
    try {
      await _authService.signOut();
      // The stream listener will automatically emit Unauthenticated
    } on Exception catch (e) {
      emit(AuthErrorState(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
