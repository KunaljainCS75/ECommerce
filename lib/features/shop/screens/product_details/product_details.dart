import 'package:e_commercial_app/common/widgets/texts/section_heading.dart';
import 'package:e_commercial_app/features/shop/screens/product_details/widgets/bottom_add_to_cart.dart';
import 'package:e_commercial_app/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:e_commercial_app/features/shop/screens/product_details/widgets/product_description_box.dart';
import 'package:e_commercial_app/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:e_commercial_app/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:e_commercial_app/features/shop/screens/product_details/widgets/rating_and_share.dart';
import 'package:e_commercial_app/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:e_commercial_app/utils/constants/colors.dart';
import 'package:e_commercial_app/utils/constants/enums.dart';
import 'package:e_commercial_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../models/product_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    super.key,
    required this.product
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAddToCart(product: product),
      body: SingleChildScrollView(
        child: Column(
          children: [

            /// Product Image Slider
            ImageSlider(product: product),

            /// Product Details
            Padding(padding: const EdgeInsets.only(right: TSizes.defaultSpace, left: TSizes.defaultSpace, bottom: TSizes.defaultSpace),
            child: Column(
              children: [

                /// Price, title, stock, brand
                ProductMetaData(product: product),
                const SizedBox(height: TSizes.spaceBtwItems),

                /// Ratings & Share button
                const RatingAndShare(),
                const SizedBox(height: TSizes.spaceBtwItems),

                /// Attributes
                if(product.productType == ProductType.variable.toString()) ProductAttributes(product: product),
                if(product.productType == ProductType.variable.toString()) const SizedBox(height: TSizes.spaceBtwSections),

                /// Checkout Button
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(side: BorderSide(color: Colors.yellow.shade700), backgroundColor: Colors.yellow.shade700), child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.energy_savings_leaf_rounded),
                    Text(' Buy Now'),
                  ],
                ))),
                const SizedBox(height: TSizes.spaceBtwItems * 2),

                /// Description
                ProductDescription(product: product),
                const SizedBox(height: TSizes.spaceBtwItems),

                const Divider(),
                const SizedBox(height: TSizes.spaceBtwItems),

                /// Reviews
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SectionHeading(title: 'Reviews (199)', onPressed: (){}, showActionButton: false),
                    IconButton(onPressed: () => Get.to(() => const ProductReviewsScreen()),
                        icon: const Icon(Iconsax.arrow_right_3,
                        size: 18, color: TColors.white,))
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
              ],
            ),),
          ],
        ),
      ),
    );
  }
}




