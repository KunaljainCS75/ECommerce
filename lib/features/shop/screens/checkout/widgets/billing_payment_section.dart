import 'package:e_commercial_app/utils/constants/sizes.dart';
import 'package:e_commercial_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../controllers/product/checkout_controller.dart';

class BillingPaymentSection extends StatelessWidget {
  const BillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(CheckoutController());
    return Column(
      children: [
        SectionHeading(title: 'Payment Method', buttonTitle: 'Change',
          showActionButton:  true,
          onPressed: () => controller.selectPaymentMethod(context),
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        Obx(
          () => Row(
            children: [
              RoundedContainer(
                height: 50, width: 50,
                backgroundColor: dark? TColors.light : TColors.white,
                padding: const EdgeInsets.all(TSizes.md),
                child: Image(image: AssetImage(controller.selectedPaymentMethod.value.image), fit: BoxFit.contain),
              ),
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              Text(controller.selectedPaymentMethod.value.name, style: Theme.of(context).textTheme.bodyLarge)
            ],
          ),
        )
      ],
    );
  }
}
