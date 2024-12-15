import 'package:e_commercial_app/features/shop/controllers/product/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../common/widgets/products/cart/product_quantity_add_remove.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../utils/constants/sizes.dart';

class CartItems extends StatelessWidget {
  const CartItems({super.key,
    this.showAddRemoveButton = true
  });

  final bool showAddRemoveButton;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;

    return Obx(() => ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwSections),
          itemCount: cartController.cartItems.length,

          scrollDirection: Axis.vertical,
          itemBuilder: (_, index)
          => Obx(() {
            final item = cartController.cartItems[index];
            return Column(
                children: [
                CartItem(cartItem: item),
                if (showAddRemoveButton) const SizedBox(height: TSizes.spaceBtwItems),

                /// Add Remove Button with total price
                if (showAddRemoveButton) Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        /// Extra Space
                        const SizedBox(width: 70),

                        /// Remove / Add Buttons
                        ProductQtyAddSubtract(
                          quantity: item.quantity,
                          add: () => cartController.addOneToCart(item),
                          subtract: () => cartController.removeOneFromCart(item),
                        ),
                      ],
                    ),
                    PriceText(price: (item.price * item.quantity).toStringAsFixed(1))
                  ],
                )
              ],
    );
  }
            ),
          )
    );
  }
}
