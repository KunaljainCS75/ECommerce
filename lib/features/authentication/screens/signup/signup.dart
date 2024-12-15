import 'package:e_commercial_app/features/authentication/screens/signup/signupform.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/login_signUp/divider.dart';
import '../../../../common/widgets/login_signUp/socialbuttons.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TITLE
              Text(TTexts.signupTitle,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// FORM
              const SignUpForm(),

              /// Divider
              const SizedBox(height: TSizes.spaceBtwSections),
              TDivider(dividerText: TTexts.orSignInWith.capitalize!),

              /// Social Buttons
              const SizedBox(height: TSizes.spaceBtwSections),
              const SocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}


