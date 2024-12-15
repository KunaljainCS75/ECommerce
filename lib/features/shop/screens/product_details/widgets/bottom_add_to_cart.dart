import 'package:e_commercial_app/common/widgets/icons/circular_icon.dart';
import 'package:e_commercial_app/features/shop/controllers/product/cart_controller.dart';
import 'package:e_commercial_app/utils/constants/colors.dart';
import 'package:e_commercial_app/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../models/product_model.dart';

class BottomAddToCart extends StatelessWidget {
  const BottomAddToCart({
    super.key,
    required this.product
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    controller.updateAlreadyAddedProductCount(product);

    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
      decoration: BoxDecoration(
        color: dark? TColors.darkerGrey : TColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(TSizes.cardRadiusLg),
          topRight: Radius.circular(TSizes.cardRadiusLg),
        )
      ),
      child: Obx(
        () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircularIcon(
                    icon: Iconsax.minus,
                    width: 50, height: 50,
                    backgroundColor: TColors.black.withOpacity(0.5),
                    color: TColors.white,
                    onPressed: () => controller.productQuantityInCart.value < 1 ? null : controller.productQuantityInCart.value -= 1,
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Text(controller.productQuantityInCart.value.toString(), style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(width: TSizes.spaceBtwItems),

                  CircularIcon(
                    icon: Iconsax.add,
                    width: 50, height: 50,
                    backgroundColor: TColors.black,
                    color: TColors.white,
                    onPressed: () => controller.productQuantityInCart.value += 1,
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () => controller.addToCart(product),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(TSizes.md),
                    backgroundColor: Colors.deepOrange,
                    side: const BorderSide(color: Colors.deepOrange),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.shopping_cart_sharp),
                      Text('  Add to Cart'),
                    ],
                  )
              ),
            ],
          ),
      ),
    );
  }
}
