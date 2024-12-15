import 'package:e_commercial_app/features/authentication/controllers/signup/signup_controller.dart';
import 'package:e_commercial_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/text_strings.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = SignupController.instance;
    return Row(
      children: [
        SizedBox(width: 24, height: 24, child: Obx(() => Checkbox(value: controller.privacyPolicy.value, onChanged: (value) => controller.privacyPolicy.value = !controller.privacyPolicy.value))),
        const SizedBox(width: 5),
        Text.rich(
            TextSpan(
                children: [
                  TextSpan(text: '${TTexts.iAgreeTo} ', style: Theme.of(context).textTheme.bodySmall),
                  TextSpan(text: TTexts.privacyPolicy,
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: dark? TColors.white : TColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: dark? TColors.white : TColors.primary,
                      )),
                  TextSpan(text: ' ${TTexts.and} ', style: Theme.of(context).textTheme.bodySmall),
                  TextSpan(text: TTexts.termsOfUse,
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: dark? TColors.white : TColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: dark? TColors.white : TColors.primary,
                      )),

                ])),
      ],
    );
  }
}