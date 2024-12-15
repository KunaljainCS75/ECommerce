import 'package:e_commercial_app/common/widgets/texts/section_heading.dart';
import 'package:e_commercial_app/features/personalization/controllers/address_controller.dart';
import 'package:e_commercial_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class BillingAddressSection extends StatelessWidget {
  const BillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return SingleChildScrollView(
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeading(title: 'Shipping Address', buttonTitle: 'Change',
              showActionButton:  true,
              onPressed: () => controller.selectNewAddressPopup(context),
            ),
            controller.selectedAddress.value.id.isNotEmpty ?
             Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(controller.selectedAddress.value.name, style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),

                  Row(
                    children: [
                      const Icon(Icons.phone, color: Colors.grey, size: 16),
                      const SizedBox(width: TSizes.spaceBtwItems),
                      Text(controller.selectedAddress.value.phoneNumber, style: Theme.of(context).textTheme.bodyMedium)
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),

                  Row(
                    children: [
                      const Icon(Icons.location_history, color: Colors.grey, size: 16),
                      const SizedBox(width: TSizes.spaceBtwItems),
                      Expanded(child: Text(controller.selectedAddress.value.toString(), style: Theme.of(context).textTheme.bodyMedium, softWrap: true))
                    ],
                  ),
                ],
            ) : Text ('Select Address', style: Theme.of(context).textTheme.bodyMedium)
          ],
        ),
      ),
    );
  }
}
