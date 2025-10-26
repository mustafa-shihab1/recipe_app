import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/features/main/presentation/view/main_view.dart';

import '../../config/dependency_injection.dart';
import '../../features/auth/presentation/controller/auth_cubit.dart';
import '../../features/auth/presentation/controller/auth_state.dart';
import '../../features/auth/presentation/view/create_account_view.dart';
import '../../features/onboarding/view/onboarding_view.dart';
import '../storage/local/app_settings_shared_preferences.dart';

class AppStartView extends StatelessWidget {
  const AppStartView({super.key});

  @override
  Widget build(BuildContext context) {
    // The BlocProvider has been moved to main.dart, wrapping the MaterialApp.
    // This widget now simply builds based on the state of the single, global AuthCubit.
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccessState) {
          // User is logged in, go to the main screen
          return const MainView();
        } else if (state is Unauthenticated) {
          // User is not logged in, now check for onboarding
          return FutureBuilder<bool>(
            future: _isFirstTime(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data == true) {
                  return const OnboardingView(); // First time user
                } else {
                  return const CreateAccountView(); // Returning user
                }
              }
              // While checking if it's the first time, show a loading indicator
              return const Scaffold(
                  body: Center(child: CircularProgressIndicator()));
            },
          );
        } else {
          // This covers AuthInitial and AuthLoading
          // Show a splash screen or loading indicator while checking auth state
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Future<bool> _isFirstTime() async {
    final appSettings = instance<AppSettingsSharedPreferences>();
    try {
      final isViewed = appSettings.getOutBoardingViewed();
      return !isViewed;
    } catch (e) {
      // If there's an error reading from shared prefs, assume it's the first time
      return true;
    }
  }
}
