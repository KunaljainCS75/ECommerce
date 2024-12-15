import 'package:e_commercial_app/features/personalization/controllers/address_controller.dart';
import 'package:e_commercial_app/features/personalization/models/address/address_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class SingleAddress extends StatelessWidget {
  const SingleAddress({
    super.key,
    required this.address,
    required this.onTap
  });

  final AddressModel address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    final dark = THelperFunctions.isDarkMode(context);

    return Obx(
      () {
        final selectedAddressId = controller.selectedAddress.value.id;
        final selectedAddress = selectedAddressId == address.id;
        return InkWell(
          onTap: onTap,
          child: RoundedContainer(
            padding: const EdgeInsets.all(TSizes.md),
            width: double.infinity,
            showBorder: true,
            backgroundColor: selectedAddress
                ? TColors.primary.withOpacity(0.5)
                : Colors.transparent,
            borderColor: selectedAddress ? Colors.transparent : dark ? TColors
                .darkerGrey : TColors.grey,
            margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
            child: Stack(
              children: [
                Positioned(
                    top: 0, right: 5,
                    child: Icon(
                        selectedAddress ? Iconsax.tick_circle5 : null,
                        color: selectedAddress ? dark ? TColors.light : TColors
                            .dark.withOpacity(0.7) : null)
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(address.name,
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLines: 2, overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: TSizes.sm / 2),
                    Text('(${address.formattedPhoneNo})', maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(height: TSizes.sm / 2),
                    Text(address.toString(),
                      softWrap: true,)

                  ],
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
