import 'package:e_commercial_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_commercial_app/common/widgets/images/rounded_images.dart';
import 'package:e_commercial_app/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:e_commercial_app/features/shop/screens/product_details/product_details.dart';
import 'package:e_commercial_app/utils/constants/colors.dart';
import 'package:e_commercial_app/utils/constants/enums.dart';
import 'package:e_commercial_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../features/shop/controllers/product/product_controller.dart';
import '../../../../features/shop/models/product_model.dart';
import '../../../../features/shop/screens/cart/widgets/product_add_to_cart_button.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../styles/shadows.dart';
import '../../icons/circular_icon.dart';
import '../../texts/brand_title_text.dart';
import '../../texts/product_price_text.dart';
import '../../texts/product_title_text.dart';

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({
    super.key,
    required this.product
  });
  final ProductModel product;
  @override
  Widget build(BuildContext context) {

    final controller = ProductController.instance;
    final dark = THelperFunctions.isDarkMode(context);

    Color salesTagColor = TColors.secondary.withOpacity(0.8);
    final salesPercentage = controller.calculateSalesPercentage(product.price, product.salePrice);
    if (salesPercentage > 50) {
      salesTagColor = Colors.red;
    }

    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailsScreen(product: product)),
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          // boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius), // 16
          color: dark? TColors.darkerGrey : TColors.white
        ),
        child: Column(

          children: [
            /// Thumbnail, WishList Button, DiscountIcon
            RoundedContainer(
              width: 180,
              height: 165,
              showBorder: true,
              borderColor: dark? TColors.white.withOpacity(0.3) : TColors.black.withOpacity(0.3),
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark? TColors.dark : TColors.light,
              child: Stack(
                children: [
                  // Container(
                  //     decoration:
                  //     BoxDecoration(borderRadius: BorderRadius.circular(10),
                  //         border: Border.all(color: Colors.black87)),
                  // ),
                  /// THUMBNAIL
                  Center(child: RoundedImage(imgUrl: product.thumbnail, applyImageRadius: true, isNetworkImage: true)),

                  /// SaleTag
                  if (salesPercentage > 0)
                    Positioned(
                      top: 0,
                      child: RoundedContainer(
                        radius: TSizes.sm,
                        backgroundColor: salesTagColor,
                        padding: const EdgeInsets.symmetric(horizontal: TSizes.sm, vertical: TSizes.xs),
                        child: Text('$salesPercentage% off', style: Theme.of(context).textTheme.labelLarge!.apply(color: salesPercentage > 50 ? TColors.white : Colors.black87, fontWeightDelta: 3)),
                      ),
                    ),

                  /// FavouriteIconButton
                  Positioned(
                      top: 0,
                      right: 0,
                      child: FavouriteIcon(productId: product.id)
                  )
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),

            /// Details (Product_name, brand, Price)
            Padding(
              padding: const EdgeInsets.only(left: TSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductTitleText(title: product.title, smallSize: true),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  BrandTitleText(title: product.brand!.name, iconSize: TSizes.xl / 2),
                ],
              ),
            ),

            // Todo: ADD SPACER() to have same size of all product cards in case of 2 or more lines of title;
            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                /// Price
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      if(product.salePrice > 0)
                        Padding(
                        padding: const EdgeInsets.only(left: TSizes.sm),
                        child: Text(
                        "${product.price}",
                            style: Theme.of(context).textTheme.labelMedium!.apply(decoration: TextDecoration.lineThrough)
                        ),
                      ),

                      /// Price, Show sale price as main price if sale exist
                      if (product.salePrice > 0)
                        Padding(
                          padding: const EdgeInsets.only(left: TSizes.sm, bottom: TSizes.sm),
                          child: PriceText(price: controller.getProductPrice(product).split('-')[0])
                      ),


                      if (product.salePrice == 0)
                        const SizedBox(height: 10),
                      if (product.salePrice == 0)
                        Padding(
                            padding: const EdgeInsets.only(left: TSizes.sm, bottom: TSizes.sm),
                            child: Text("₹ ${product.price.toString()}", style: Theme.of(context).textTheme.titleLarge!.apply(fontWeightDelta: 2))
                        ),
                    ],
                  ),
                ),

                /// Cart Button
                ProductAddToCartButton(product: product)
              ],
            ),
          ],
        ),
      ),
    );
  }
}







