import 'package:flutter/material.dart';

import '../../../../../core/resources/colors_manager.dart';
import '../login_view.dart';
import '../register_view.dart';
import 'social_media_buttons.dart';

class CreateAccountBottomSheet extends StatelessWidget {
  const CreateAccountBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 16),

            // Create Account Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Replace the current screen with the RegisterView
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterView(),));
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  backgroundColor: ColorsManager.primaryColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/icons/email.png'),
                    const SizedBox(width: 5),
                    const Text(
                      'Register using email',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            SocialMediaButtons(),
            const SizedBox(height: 24),
            // Have an account? Login
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Have an account? '),
                GestureDetector(
                  onTap: () {
                    // Replace the current screen with the LoginView
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginView(),));
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: ColorsManager.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
