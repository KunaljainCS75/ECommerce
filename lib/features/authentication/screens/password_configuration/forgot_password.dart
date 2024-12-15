import 'package:e_commercial_app/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:e_commercial_app/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(),
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

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Headings
          Text(TTexts.forgetPasswordTitle, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: TSizes.spaceBtwSections),
          Text(TTexts.forgetPasswordSubTitle, style: Theme.of(context).textTheme.labelMedium),
          const SizedBox(height: TSizes.spaceBtwSections * 2),

          /// TextField
          Form(
            key: controller.forgetPasswordFormKey,
            child: TextFormField(
              controller: controller.email,
              validator: (value) => Validator.validateEmail(value),
              decoration: const InputDecoration(
                labelText: TTexts.email,
                prefix: Icon(Iconsax.direct_right)
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwSections),

          /// Submit Button
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => controller.sendResetPasswordEmail(), child: const Text(TTexts.submit)))
        ],

      ),)
    );
  }
}
