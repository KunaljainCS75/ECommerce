import 'dart:ffi';

import 'package:e_commercial_app/common/widgets/appbar/tabbar.dart';
import 'package:e_commercial_app/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:e_commercial_app/common/widgets/layouts/grid_layout.dart';
import 'package:e_commercial_app/common/widgets/loaders/brands_shimmer.dart';
import 'package:e_commercial_app/common/widgets/loaders/shimmer_loader.dart';
import 'package:e_commercial_app/common/widgets/texts/section_heading.dart';
import 'package:e_commercial_app/features/shop/all_brands/all_brands.dart';
import 'package:e_commercial_app/features/shop/all_brands/brands_product.dart';
import 'package:e_commercial_app/features/shop/controllers/brand_controller.dart';
import 'package:e_commercial_app/features/shop/controllers/category_controller.dart';
import 'package:e_commercial_app/features/shop/screens/store/widgets/category_tab.dart';
import 'package:e_commercial_app/features/shop/screens/store/widgets/store_appbar.dart';
import 'package:e_commercial_app/utils/constants/image_strings.dart';
import 'package:e_commercial_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/brands/brand_card.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = Get.put(BrandController()); // Create new instance if not found any existing instance.
    final dark = THelperFunctions.isDarkMode(context);
    final categories = CategoryController.instance.featuredCategories;
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        backgroundColor: dark? TColors.black : TColors.white,
        appBar: const StoreAppBar(),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: dark ? TColors.black : TColors.white,
                expandedHeight: 440,

                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,  //occupy only current children space
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      /// -- Search Bar
                      const SizedBox(height: TSizes.spaceBtwItems),
                      const SearchBarContainer(text: 'Search in Store', showBorder: true, padding: EdgeInsets.zero,),
                      const SizedBox(height: TSizes.spaceBtwSections / 2,),

                      /// -- Featured Brands
                      SectionHeading(title: 'Featured Brands', onPressed: () => Get.to(() => const AllBrandsScreen()), textColor: dark? Colors.white : TColors.black),
                      const SizedBox(height: TSizes.spaceBtwItems / 1.5),

                      /// -- Brands GRID
                      Obx(
                        () {
                          if (brandController.isLoading.value) return BrandsShimmer(itemCount: brandController.featuredBrands.length);
                          if (brandController.featuredBrands.isEmpty) {
                            return Center(
                                child: Text(
                                    'No Data Found',
                                    style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white)));
                          }

                          return GridLayout(
                          itemCount: brandController.featuredBrands.length,
                          mainAxisExtent: 80,
                          itemBuilder: (_, index) {
                            final brand = brandController.featuredBrands[index];
                            return ProductBrandCard(
                                brand: brand,
                                showBorder: true,
                                onTap: () => Get.to(() => BrandsProducts(brand: brand)),
                              );
                            },
                          );
                        }
                      ),
                    ],
                  )
                ),

                /// TABS
                bottom: TaBBar(tabs: categories.map((category) => Tab(child: Text(category.name))).toList()
                ),
              ),
            ];
          },
          body: TabBarView(
            children: categories.map((category) => CategoryTab(category: category)).toList()
          ),
        ),
      ),
    );
  }
}





