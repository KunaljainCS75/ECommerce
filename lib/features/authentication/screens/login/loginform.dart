import 'package:e_commercial_app/features/authentication/controllers/login/login_controller.dart';
import 'package:e_commercial_app/features/authentication/screens/password_configuration/forgot_password.dart';
import 'package:e_commercial_app/features/authentication/screens/signup/signup.dart';
import 'package:e_commercial_app/navigation_menu.dart';
import 'package:e_commercial_app/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
              /// Email
              TextFormField(
                controller: controller.email,
                validator: (value) => Validator.validateEmail(value),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: TTexts.email,
                )),
              const SizedBox(height: TSizes.spaceBtwInputFields),

            /// PASSWORD
            Obx(
                  ()=> TextFormField(
                controller: controller.password,
                validator: (value) => Validator.validateEmptyText('Password', value),
                obscureText: controller.hidePassword.value,
                expands: false,
                decoration: InputDecoration(
                    labelText: TTexts.password,
                    prefixIcon: const Icon(Iconsax.password_check),
                    suffixIcon: IconButton(
                        icon: !controller.hidePassword.value? const Icon(Iconsax.eye_slash) : const Icon(Iconsax.eye),
                        onPressed: () => controller.hidePassword.value = !controller.hidePassword.value)),
              ),
            ),

              /// Remember Me & Forget Password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Remember Me
                  Row(
                    children: [
                      Obx(() => Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: (value) => controller.rememberMe.value = !controller.rememberMe.value)),
                      const Text(TTexts.rememberMe)
                    ],
                  ),

                  /// Forget Password
                  TextButton(
                      onPressed: () => Get.to(() => const ForgotPassword()),
                      child: const Text(TTexts.forgetPassword)),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              /// Sign-In Button
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => controller.emailAndPasswordSignIn(),
                      child: const Text(TTexts.signIn))),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Create Account Button
              SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                      onPressed: () => Get.to(() => const SignUpScreen()),
                      child: const Text(TTexts.createAccount))),
            ],
          ),
        ));
  }
}