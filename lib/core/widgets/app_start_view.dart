import 'package:flutter/material.dart';

import '../../config/dependency_injection.dart';
import '../../features/auth/presentation/view/login_view.dart';
import '../../features/main/presentation/view/main_view.dart';
import '../../features/onboarding/view/onboarding_view.dart';
import '../firebase/firebase_auth_service.dart';
import '../storage/local/app_settings_shared_preferences.dart';

class AppStartView extends StatelessWidget {
  const AppStartView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = instance<FirebaseAuthService>().currentUser;

    if (user != null) {
      initMain();
      return const MainView();
    } else {
      initAuth();

      // check if the user has seen the onboarding screen.
      return FutureBuilder<bool>(
        future: _isFirstTime(),
        builder: (context, onboardingSnapshot) {
          if (onboardingSnapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          if (onboardingSnapshot.data == true) {
            // First time user, show onboarding.
            return const OnboardingView();
          } else {
            // Returning user who is not logged in, show login.
            return LoginView();
          }
        },
      );
    }
  }

  Future<bool> _isFirstTime() async {
    final appSettings = instance<AppSettingsSharedPreferences>();
    try {
      final isViewed = appSettings.getOutBoardingViewed();
      return !isViewed;
    } catch (e) {
      return true;
    }
  }
}
