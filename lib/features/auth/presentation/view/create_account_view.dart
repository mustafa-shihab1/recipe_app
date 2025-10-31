import 'package:flutter/material.dart';

import '../../../../core/device/device_utility.dart';
import '../../../../core/resources/assets_manager.dart';
import 'widgets/create_account_bottom_sheet.dart';

class CreateAccountView extends StatelessWidget {
  const CreateAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetsManager.createAccBg),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.9),
                ],
              ),
            ),
          ),
          Positioned(
            left: 16,
              bottom: DeviceUtility.getBottomNavigationBarHeight() +230,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
            // Title
            const Text(
              'Create an Account',
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,

              ),
            ),
            const SizedBox(height: 8),
            // Subtitle
            Text(
              'Join us today! Create an account to get started.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],)),
          // Bottom Content Sheet
          CreateAccountBottomSheet(),
        ],
      ),
    );
  }
}


