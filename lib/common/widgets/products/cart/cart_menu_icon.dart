import 'package:e_commercial_app/features/shop/screens/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../features/shop/controllers/product/cart_controller.dart';
import '../../../../utils/constants/colors.dart';

class CartCounterAndMenuIcon extends StatelessWidget {
  const CartCounterAndMenuIcon({
    super.key,
    this.iconColor,
    this.counterBgColor = Colors.yellow,
    this.counterTextColor = TColors.black
  });

  final Color? iconColor, counterTextColor, counterBgColor;

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(CartController());

    return Stack(
      children: [
      IconButton(onPressed: () => Get.to(() => const CartScreen()),
          icon: Icon(Iconsax.shopping_bag, color: iconColor)),
      Positioned(
        right: 0,
        child: Container(
          width: 23, height: 23,
          decoration: BoxDecoration(color: counterBgColor, borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
              child: Obx(
                  () => Text(controller.noOfCartItems.value.toString(),
                  style: Theme.of(context).textTheme.labelLarge!
                      .apply(color: counterTextColor, fontSizeFactor: 1.2, fontWeightDelta: 3),),
              )),
        ),
      )
    ]);
  }
}
