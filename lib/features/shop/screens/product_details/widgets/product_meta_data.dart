import 'package:e_commercial_app/common/widgets/images/circular_images.dart';
import 'package:e_commercial_app/common/widgets/texts/brand_title_text.dart';
import 'package:e_commercial_app/common/widgets/texts/product_title_text.dart';
import 'package:e_commercial_app/features/shop/controllers/product/product_controller.dart';
import 'package:e_commercial_app/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../models/product_model.dart';

class ProductMetaData extends StatelessWidget {
  const ProductMetaData({
    required this.product
  });
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Brand
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircularImage(
                    width: 60, height: 60, overLayColor: dark? TColors.white : TColors.black,
                    image: product.brand!.image
                ),
                BrandTitleText(title: product.brand!.name, brandTextSize: TextSizes.medium),
              ],
            ),
            /// Share Button
            IconButton(onPressed: () {}, icon: const Icon(Icons.share, size: TSizes.iconMd))
          ],
        ),

        /// Title
        ProductTitleText(title: product.title, maxLines: 5),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        /// Stock Status
        Row(
          children: [
            const ProductTitleText(title: "Status : ", smallSize: true,),
            const SizedBox(width: TSizes.spaceBtwItems / 2),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                color: controller.isProductInStock(product.stock)? TColors.primary : Colors.red
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Text(controller.getProductStockStatus(product.stock),
                      style: Theme.of(context).textTheme.labelMedium!.apply(fontWeightDelta: 3, color: TColors.white)),
              ),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        /// Price & Sale-Price
        Row(
          children: [
            /// Sale Tag
            if(product.salePrice > 0)
              RoundedContainer(
                radius: TSizes.sm,
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: TSizes.sm, vertical: TSizes.xs),
                child: Text('${controller.calculateSalesPercentage(product.price, product.salePrice)}% off',style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.white, fontWeightDelta: 3)),
              ),
            if(product.salePrice > 0)
              const SizedBox(width: TSizes.spaceBtwItems),

            /// Original Price
            if (product.productType == ProductType.single.toString() && product.salePrice == 0)
              Text('₹ ${product.price}', style: Theme.of(context).textTheme.titleLarge),
            // if (product.productType == ProductType.single.toString() && product.salePrice > 0)
            //   const SizedBox(width: TSizes.spaceBtwItems),
            /// Sales Price
            if (product.productType == ProductType.single.toString() && product.salePrice > 0)
              Row(
                children: [
                  Text(product.price.toString(), style: Theme.of(context).textTheme.titleLarge!.apply(decoration: TextDecoration.lineThrough)),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Text("₹ ${product.salePrice.toString()}", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold))
                ],
              ),
            if (product.productType == ProductType.variable.toString())
            PriceText(price: controller.getProductPrice(product), isLarge: true),
          ],
        ),
      ],
    );
  }
}
