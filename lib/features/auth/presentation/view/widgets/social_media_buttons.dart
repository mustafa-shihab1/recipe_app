import 'package:flutter/material.dart';

import '../../../../../core/resources/colors_manager.dart';

class SocialMediaButtons extends StatelessWidget {
  const SocialMediaButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: ColorsManager.secondaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset('assets/icons/google.png'),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: ColorsManager.secondaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                'assets/icons/facebook.png',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
