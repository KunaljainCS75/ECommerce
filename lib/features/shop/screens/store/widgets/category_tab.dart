import 'package:e_commercial_app/common/widgets/layouts/grid_layout.dart';
import 'package:e_commercial_app/common/widgets/loaders/vertical_product_shimmer.dart';
import 'package:e_commercial_app/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:e_commercial_app/common/widgets/texts/section_heading.dart';
import 'package:e_commercial_app/features/shop/controllers/category_controller.dart';
import 'package:e_commercial_app/features/shop/models/category_model.dart';
import 'package:e_commercial_app/features/shop/screens/all_products/all_products.dart';
import 'package:e_commercial_app/features/shop/screens/store/widgets/category_brands.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/cloud_helper_functions.dart';


class CategoryTab extends StatelessWidget {
  const CategoryTab({
    super.key,
    required this.category,
  });

  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            /// -- Brands
            CategoryBrands(category: category),
            const SizedBox(height: TSizes.spaceBtwItems),

            /// -- Products
            FutureBuilder(
              future: controller.getCategoryProducts(categoryId: category.id),
              builder: (context, snapshot) {

                /// Handle Loader, no record and Error message
                final response = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: const VerticalProductShimmer());
                if (response != null) return response;

                // Record Found!
                final products = snapshot.data!;

                return Column(
                  children: [
                    SectionHeading(
                        title: 'You May also Like',
                        showActionButton: true,
                        onPressed: () =>
                            Get.to(() =>
                                AllProducts(
                                  title: category.name,
                                  futureMethod: controller.getCategoryProducts(categoryId: category.id, limit: -1),
                                ))),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    GridLayout(itemCount: products.length, itemBuilder: (_, index) => ProductCardVertical(product: products[index]))
                  ],
                );
              }
            ),

          ],
        ),
      ),
    ]
    );
  }
}