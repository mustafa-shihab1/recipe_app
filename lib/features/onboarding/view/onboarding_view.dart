import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/device/device_utility.dart';
import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/colors_manager.dart';
import '../../../core/resources/strings_manager.dart';
import '../../auth/presentation/view/create_account_view.dart';
import '../controller/onboarding_cubit.dart';
import '../controller/onboarding_state.dart';
import 'widgets/onboarding_screen.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: Scaffold(
        body: BlocConsumer<OnboardingCubit, OnboardingState>(
          listener: (context, state) {
            if (state is OnboardingFinished) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const CreateAccountView(),
                ),
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<OnboardingCubit>();
            return Stack(
              children: [
                PageView(
                  controller: cubit.pageController,
                  onPageChanged: cubit.onPageChanged,
                  children: const [
                    OnboardingScreen(
                      image: AssetsManager.onboarding1Bg,
                      title: StringsManager.onBoardingTitle1,
                      subtitle: StringsManager.onBoardingSubTitle1,
                    ),
                    OnboardingScreen(
                      image: AssetsManager.onboarding2Bg,
                      title: StringsManager.onBoardingTitle2,
                      subtitle: StringsManager.onBoardingSubTitle2,
                    ),
                    OnboardingScreen(
                      image: AssetsManager.onboarding3Bg,
                      title: StringsManager.onBoardingTitle3,
                      subtitle: StringsManager.onBoardingSubTitle3,
                    ),
                  ],
                ),

                // Smooth Page Indicator
                Positioned(
                  bottom: DeviceUtility.getBottomNavigationBarHeight(),
                  left: 20.0,

                  child: SmoothPageIndicator(
                    controller: cubit.pageController,
                    count: 3,
                    onDotClicked: cubit.dotNavigationClick,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: ColorsManager.primaryColor,
                      dotHeight: 7,
                      dotWidth: 16,
                    ),
                  ),
                ),

                // Next Button
                Positioned(
                  right: 16,
                  bottom: DeviceUtility.getBottomNavigationBarHeight(),
                  child: ElevatedButton(
                    onPressed: cubit.nextPage,
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: ColorsManager.primaryColor,
                      padding: const EdgeInsets.all(16),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
