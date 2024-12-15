import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commercial_app/common/widgets/loaders/vertical_product_shimmer.dart';
import 'package:e_commercial_app/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:e_commercial_app/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:e_commercial_app/features/shop/screens/home/widgets/home_categories.dart';
import 'package:e_commercial_app/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:e_commercial_app/utils/constants/colors.dart';
import 'package:e_commercial_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/product/product_controller.dart';
import '../all_products/all_products.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold
      (
        body: SingleChildScrollView(
          child: Column(
            children: [

              /// Header--->
              const PrimaryHeaderContainer(
                child: Column(
                  children: [

                    /// AppBar
                    ThemeAppBar(),
                    SizedBox(height: TSizes.spaceBtwItems / 2),

                    /// SearchBar
                    SearchBarContainer(text: "Search in Store"),
                    SizedBox(height: TSizes.spaceBtwSections),

                    /// Categories_Section
                    Padding(padding: EdgeInsets.only(left: TSizes.defaultSpace),
                      child: Column( children: [

                          /// Heading
                          SectionHeading(title: "Popular Categories", showActionButton: false, textColor: TColors.white),
                          SizedBox(height: TSizes.spaceBtwItems),

                          /// Categories
                          HomeCategories()
                        ],
                      ),
                    ),
                    SizedBox(height: TSizes.spaceBtwSections)
                  ],
                ),
              ),

              /// Body
              Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [

                    /// Promo_Slider
                    const PromoSlider(),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    /// Heading
                    SectionHeading(title: 'Trending Products',textColor: dark? TColors.light: TColors.black,
                        onPressed: () =>
                            Get.to(() => AllProducts
                              (title: "Trending Products",
                              futureMethod: controller.fetchAllFeaturedProducts(),
                            ))
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    /// Popular_Products (GridView)
                    Obx(() {
                      if (controller.isLoading.value) return const VerticalProductShimmer();

                      if (controller.featuredProducts.isEmpty){
                        return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium));
                      }
                      return GridLayout(
                          itemCount: controller.featuredProducts.length,
                          itemBuilder: (_, index) =>
                              ProductCardVertical(product: controller.featuredProducts[index])
                      );
                    }),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}






