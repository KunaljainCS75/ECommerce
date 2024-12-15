import 'package:e_commercial_app/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commercial_app/features/authentication/controllers/signup/verify_email_controller.dart';
import 'package:e_commercial_app/features/authentication/screens/login/login.dart';
import 'package:e_commercial_app/utils/constants/image_strings.dart';
import 'package:e_commercial_app/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/login_signUp/success_screen.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({
    super.key,
    this.email
  });

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(

      /// The close or cross button is used to redirect user to login screen and logout the user
      /// After registration process, user go to mailbox and click link to verify email and in that case,
      /// we need redirect user to success screen upon reopening app after checking mailbox.
      /// If not verified, stay on verification screen..

      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove back arrow from appbar
        actions: [
          IconButton(onPressed: () => AuthenticationRepository.instance.logout(), icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        /// padding for equal sizes from all sides of screen.
        child: Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column (
          children: [
            /// IMAGE
            Image(image: const AssetImage(TImages.deliveredEmailIllustration), width: THelperFunctions.screenWidth() *0.6,),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Title & Subtitle
            Text(TTexts.confirmEmail, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
            const SizedBox(height: TSizes.spaceBtwSections),
            Text(email ?? ' ', style: Theme.of(context).textTheme.labelLarge, textAlign: TextAlign.center),
            const SizedBox(height: TSizes.spaceBtwSections),
            Text(TTexts.confirmEmailSubTitle, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Buttons
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.checkEmailVerificationStatus(),
                    child: const Text(TTexts.tContinue)
                )
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            SizedBox(width: double.infinity,
                child: TextButton(
                    onPressed: () => controller.sendEmailVerification(),
                    child: const Text(TTexts.resendEmail))),
          ],
        ),),
      ),
    );
  }
}
