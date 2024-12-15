import 'package:e_commercial_app/features/personalization/controllers/user_controller.dart';
import 'package:e_commercial_app/utils/constants/text_strings.dart';
import 'package:e_commercial_app/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/sizes.dart';

class ReAuthenticateUserLoginForm extends StatelessWidget {
  const ReAuthenticateUserLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: const Text('Re-Authenticate User')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Form(
          key: controller.reAuthFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Email
              TextFormField(
                controller: controller.verifyEmail,
                validator: (value) => Validator.validateEmail(value),
                decoration: const InputDecoration(prefixIcon: Icon(Iconsax.direct_right), labelText: TTexts.email),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              /// Password
              Obx(
                () => TextFormField(
                  controller: controller.verifyPassword,
                  validator: (value) => Validator.validatePassword(value),
                  obscureText: controller.hidePassword.value,
                  decoration: InputDecoration(
                      labelText: TTexts.password,
                      prefixIcon: const Icon(Iconsax.password_check),
                      suffixIcon:  IconButton(
                          icon: !controller.hidePassword.value? const Icon(Iconsax.eye_slash) : const Icon(Iconsax.eye),
                          onPressed: () => controller.hidePassword.value = !controller.hidePassword.value)),
                  ),
                ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// LOGIN Button
              /// Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () => controller.reAuthenticateEmailAndPasswordUser(), child: const Text('Verify')),
              )
            ],
          ),
        ),
      )
    );
  }
}
