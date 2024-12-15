import 'package:e_commercial_app/features/shop/models/product_model.dart';
import 'package:e_commercial_app/features/shop/screens/product_details/product_details.dart';
import 'package:e_commercial_app/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/product/cart_controller.dart';

class ProductAddToCartButton extends StatelessWidget {
  const ProductAddToCartButton({
    super.key,
    required this.product
  });

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return InkWell(
      onTap: () {
        // If product has variation then show the product details for variation selection
        if (product.productType == ProductType.single.toString()){
          final cartItem = cartController.convertToCartItemModel(product, 1);
          cartController.addOneToCart(cartItem);
        }
        // Else Add the product
        else {
          Get.to(() => ProductDetailsScreen(product: product));
        }
      },
      child: Obx(() {
        final productQuantityInCart = cartController.getProductQuantityInCart(product.id);
        return Container(
            decoration: BoxDecoration(
              color: productQuantityInCart > 0 ? TColors.primary : TColors.black,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(TSizes.cardRadiusMd),
                  bottomRight: Radius.circular(TSizes.productImageRadius)
              ),
            ),
            child: SizedBox(
                height: TSizes.iconLg * 1.3,
                width: TSizes.iconLg * 1.2,
                child: Center(
                    child: productQuantityInCart > 0
                              ? Text(productQuantityInCart.toString(), style: Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.white))
                              : const Icon(Iconsax.add, color: TColors.white)
                )
            ),
          );
          }
      ),
    );
  }
}
