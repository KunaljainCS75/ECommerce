import 'package:e_commercial_app/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../login/login.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({
    super.key,
    required this.email
  });
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [IconButton(onPressed: () => Get.back(), icon: const Icon(CupertinoIcons.clear))],
        ),
        body: Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            /*
        For Row:
        mainAxisAlignment = Horizontal Axis
        crossAxisAlignment = Vertical Axis

        For Column:
        mainAxisAlignment = Vertical Axis
        crossAxisAlignment = Horizontal Axis

        CrossAxisAlignment.start: Aligns children at the start of the cross axis.
                                  In a Row, this means the children are aligned at the top;
                                  in a Column, they align at the left.
        CrossAxisAlignment.end: Aligns children at the end of the cross axis.
                                In a Row, this means the children are aligned at the bottom;
                                in a Column, they align at the right.*/

            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// IMAGE
              Image(image: const AssetImage(TImages.deliveredEmailIllustration), width: THelperFunctions.screenWidth() *0.6,),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Email, Title & Subtitle
              Text(email, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(TTexts.changeYourPasswordTitle, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(TTexts.changeYourPasswordSubTitle, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Buttons
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Get.offAll(() => const LoginScreen()), child: const Text(TTexts.done))),
              const SizedBox(height: TSizes.spaceBtwSections),
              SizedBox(width: double.infinity, child: TextButton(onPressed: () => ForgetPasswordController.instance.resendResetPasswordEmail(email), child: const Text(TTexts.resendEmail))),
            ],

          ),)
    );
  }
}