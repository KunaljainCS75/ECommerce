import 'package:e_commercial_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_commercial_app/common/widgets/loaders/animation_loader.dart';
import 'package:e_commercial_app/features/shop/controllers/product/order_controller.dart';
import 'package:e_commercial_app/utils/constants/colors.dart';
import 'package:e_commercial_app/utils/constants/sizes.dart';
import 'package:e_commercial_app/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../navigation_menu.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class OrdersListItems extends StatelessWidget {
  const OrdersListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    final dark = THelperFunctions.isDarkMode(context);
    return FutureBuilder(
      future: controller.fetchUserOrders(),
      builder: (context, snapshot) {
        final emptyWidget = AnimationLoader(
          text: 'Whoops! No Orders Yet!',
          animation: TImages.productsIllustration,
          showAction: true,
          actionText: "Try to order products and come back then...",
          onActionPressed: () => Get.off(() => const NavigationMenu()),
        );
        final response = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, nothingFound: emptyWidget);
        if (response != null) return response;

        final orders = snapshot.data!;
        return ListView.separated(
          shrinkWrap: true,
          itemCount: orders.length,
          separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwItems),
          itemBuilder: (_, index) => RoundedContainer(
            showBorder: true,
            backgroundColor: dark? TColors.dark : TColors.light,
            child: Padding(
              padding: const EdgeInsets.all(TSizes.md),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// -- Row 1
                  Row(
                    children: [
                      /// Icon
                      const Icon(Iconsax.ship),
                      const SizedBox(width: TSizes.spaceBtwItems),

                      /// Status & Date
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("Status : ", style: Theme.of(context).textTheme.bodySmall),
                                Text(orders[index].orderStatusText, style: Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.primary, fontWeightDelta: 2)),
                              ],
                            ),
                            Text(orders[index].formattedOrderDate, style: Theme.of(context).textTheme.headlineSmall),
                          ],
                        ),
                      ),
                      IconButton(onPressed: (){}, icon: const Icon(Iconsax.arrow_right_34, size: TSizes.iconSm))
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),

                  /// --- Row 2
                  Row(
                    children: [
                      /// Order Number
                      Expanded(
                        child: Row(
                          children: [
                            /// Icon
                            const Icon(Iconsax.tag),
                            const SizedBox(width: TSizes.spaceBtwItems),

                            /// Order No.
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Order ID', style: Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.primary, fontWeightDelta: 1)),
                                  Text(orders[index].id, style: Theme.of(context).textTheme.bodyLarge),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// Shipping Date
                      Expanded(
                        child: Row(
                          children: [
                            /// Icon
                            const Icon(Iconsax.calendar),
                            const SizedBox(width: TSizes.spaceBtwItems),

                            /// Date
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Shipping Date', style: Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.primary, fontWeightDelta: 1)),
                                  Text(orders[index].formattedDeliveryDate , style: Theme.of(context).textTheme.bodyLarge),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}



    
    