import 'package:flutter/material.dart';
import 'package:recipe_app/core/resources/assets_manager.dart';
import 'package:recipe_app/core/resources/colors_manager.dart';

import '../../../../core/firebase/firebase_auth_service.dart';
import '../../../../routes/routes.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        children: [
          Column(
            children: [
              const CircleAvatar(
                radius: 55,
                backgroundColor: Colors.black12,
                backgroundImage: AssetImage(AssetsManager.profilePlaceholder),
              ),
              const SizedBox(height: 16),
              Text(
                'Mustafa Shihab',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                FirebaseAuthService().currentUser?.email ??
                    'email@example.com',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
              ),
            ],
          ),
          const SizedBox(height: 40),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.09),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildProfileMenuItem(
                    icon: Icons.edit_outlined,
                    title: 'Edit Profile',
                    onTap: () {},
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  _buildProfileMenuItem(
                    icon: Icons.lock_reset_sharp,
                    title: 'Change Password',
                    onTap: () {},
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  _buildProfileMenuItem(
                    icon: Icons.notifications_none_rounded,
                    title: 'Notifications',
                    onTap: () {},
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  _buildProfileMenuItem(
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    title: const Text('Logout'),
                    content: const Text(
                      'Are you sure you want to logout?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () =>
                            Navigator.pop(dialogContext),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          FirebaseAuthService().signOut().then((_) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              Routes.loginView,
                                  (route) => false,
                            );
                          });

                        },
                        child: const Text(
                          'Yes',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                side: BorderSide(color: Colors.redAccent),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.redAccent, fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildProfileMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isLogout ? Colors.redAccent : ColorsManager.primaryColor,
        size: 24,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: isLogout ? Colors.redAccent : Colors.black.withOpacity(0.75),
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,

    );
  }
}
