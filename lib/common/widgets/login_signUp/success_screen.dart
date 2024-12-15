import 'package:e_commercial_app/common/styles/spacingStyles.dart';
import 'package:e_commercial_app/features/authentication/screens/login/login.dart';
import 'package:e_commercial_app/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/helpers/helper_functions.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.image, required this.title, required this.subtitle, this.onPressed});

  final String image, title, subtitle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight * 2,
          child: Column(
            children: [
              /// IMAGE
              Image(image: AssetImage(image), width: THelperFunctions.screenWidth() *0.6,),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Title & Subtitle
              Text(title, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwSections),
              Text(subtitle, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Buttons
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Get.to(() => const NavigationMenu()), child: const Text(TTexts.tContinue))),
            ],
          ),
        ),
      ),
    );
  }
}
