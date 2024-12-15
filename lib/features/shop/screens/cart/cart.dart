import 'package:e_commercial_app/common/widgets/appbar/appbar.dart';
import 'package:e_commercial_app/common/widgets/loaders/animation_loader.dart';
import 'package:e_commercial_app/features/shop/controllers/product/cart_controller.dart';
import 'package:e_commercial_app/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:e_commercial_app/features/shop/screens/checkout/checkout.dart';
import 'package:e_commercial_app/navigation_menu.dart';
import 'package:e_commercial_app/utils/constants/image_strings.dart';
import 'package:e_commercial_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;

    return Scaffold(
      appBar: TAppBar(title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall), isColor: true),
      body: Obx(() {

        /// Nothing Found
        final emptyWidget = Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage(TImages.emptyCart), height: 150,),
            AnimationLoader(
              text: 'Whoops!, Your cart is empty',
              animation: TImages.emptyCart,
              showAction: true,
              actionText: "Try to add some products...",
              onActionPressed: () => Get.off(() => const NavigationMenu()),
            ),
            SizedBox(height: 150)
          ],
        );

        if (controller.cartItems.isEmpty) {
          return emptyWidget;
        } else {
          return Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: CartItems(),
              );
        }
        }
      ),
      bottomNavigationBar: controller.cartItems.isEmpty
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: ElevatedButton(
                  onPressed: () => Get.to(() => const CheckOutScreen()),
                  child: Obx(() => Text('Checkout : ₹ ${controller.totalCartPrice.value}'))),
      ),
    );
  }
}


   

