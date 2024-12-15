import 'package:e_commercial_app/features/authentication/controllers/signup/signup_controller.dart';
import 'package:e_commercial_app/features/authentication/screens/signup/terms_and_conditions.dart';
import 'package:e_commercial_app/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());

    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) => Validator.validateEmptyText('First name', value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: TTexts.firstName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) => Validator.validateEmptyText('Last name', value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: TTexts.lastName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              )
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// UserName
          TextFormField(
            controller: controller.username,
            validator: (value) => Validator.validateEmptyText('Username', value),
            expands: false,
            decoration: const InputDecoration(
                labelText: TTexts.username, prefixIcon: Icon(Iconsax.user)),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// EMAIL
          TextFormField(
            controller: controller.email,
            validator: (value) => Validator.validateEmail(value),
            expands: false,
            decoration: const InputDecoration(
                labelText: TTexts.email, prefixIcon: Icon(Iconsax.direct)),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// PHONE
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => Validator.validatePhoneNumber(value),
            expands: false,
            decoration: const InputDecoration(
                labelText: TTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// PASSWORD
          Obx(
            ()=> TextFormField(
              controller: controller.password,
              validator: (value) => Validator.validatePassword(value),
              obscureText: controller.hidePassword.value,
              expands: false,
              decoration: InputDecoration(
                  labelText: TTexts.password,
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(icon: !controller.hidePassword.value? const Icon(Iconsax.eye_slash) : const Icon(Iconsax.eye),
                    onPressed: () => controller.hidePassword.value = !controller.hidePassword.value)),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// Terms & Conditions
          const TermsAndConditions(),
          const SizedBox(height: TSizes.spaceBtwSections),

          /// SignUp Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: const Text(TTexts.createAccount),
            ),
          )
        ],
      ),
    );
  }
}
