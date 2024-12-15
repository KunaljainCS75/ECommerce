import 'package:e_commercial_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_commercial_app/common/widgets/images/rounded_images.dart';
import 'package:e_commercial_app/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:e_commercial_app/common/widgets/texts/brand_title_text.dart';
import 'package:e_commercial_app/common/widgets/texts/product_price_text.dart';
import 'package:e_commercial_app/common/widgets/texts/product_title_text.dart';
import 'package:e_commercial_app/features/shop/models/product_model.dart';
import 'package:e_commercial_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../features/shop/controllers/product/product_controller.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';


class ProductCardHorizontal extends StatelessWidget {
  const ProductCardHorizontal({
    super.key,
    required this.product
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salesPercentage = controller.calculateSalesPercentage(product.price, product.salePrice);
    final dark = THelperFunctions.isDarkMode(context);

    return Container(
      height: 100,
      width: 320, // or double.infinity()
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TSizes.productImageRadius), // 16
          color: dark ? TColors.darkerGrey : TColors.softGrey),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Thumbnail
          RoundedContainer(
            showBorder: true,
            height: 100, width: 140,
            padding: const EdgeInsets.all(TSizes.sm),
            backgroundColor: dark? TColors.dark : TColors.light,
            child: Stack(
              children: [
                /// Thumbnail Image
                SizedBox(
                    height: 130,
                    width: THelperFunctions.screenWidth() * 0.40,
                    child: RoundedImage(imgUrl: product.thumbnail, isNetworkImage: true,
                        applyImageRadius: true)),
                /// SaleTag
                Positioned(
                  top: 0,
                  child: RoundedContainer(
                    radius: TSizes.sm,
                    backgroundColor: TColors.secondary.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.sm, vertical: TSizes.xs),
                    child: Text('$salesPercentage% off', style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.black),),
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

          /// Details
          SizedBox(
            width: 180,
            child: Padding(
              padding: const EdgeInsets.only(top: TSizes.sm, left: TSizes.sm),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductTitleText(title: product.title, smallSize: true),
                      const SizedBox(height: TSizes.spaceBtwItems / 4),
                      BrandTitleText(title: product.brand!.name),
                    ],
                  ),
                  const Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      /// Price
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if(product.productType == ProductType.single.toString() && product.salePrice > 0)
                              Padding(
                              padding: const EdgeInsets.only(left: TSizes.sm),
                              child: Text(
                                  "₹${product.price}",
                                  style: Theme.of(context).textTheme.labelMedium!.apply(decoration: TextDecoration.lineThrough)
                              ),
                            ),

                            /// Price, Show sale price as main price if sale exist
                            if (product.salePrice > 0)
                              Padding(
                                  padding: const EdgeInsets.only(left: TSizes.sm, bottom: TSizes.sm),
                                  child: PriceText(price: controller.getProductPrice(product).split('-')[0])
                              ),
                          ],
                        ),
                      ),

                      /// Cart Button
                      Container(
                        decoration: const BoxDecoration(
                          color: TColors.primary,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(TSizes.cardRadiusMd),
                              bottomRight: Radius.circular(TSizes.productImageRadius)
                          ),
                        ),
                        child: const SizedBox(
                            height: TSizes.iconLg * 1.3,
                            width: TSizes.iconLg * 1.2,
                            child: Center(child: Icon(Iconsax.add, color: TColors.white, ))),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
