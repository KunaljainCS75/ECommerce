import 'package:e_commercial_app/common/widgets/brands/brand_card.dart';
import 'package:e_commercial_app/common/widgets/layouts/grid_layout.dart';
import 'package:e_commercial_app/common/widgets/texts/section_heading.dart';
import 'package:e_commercial_app/features/shop/all_brands/brands_product.dart';
import 'package:e_commercial_app/features/shop/controllers/brand_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/widgets/appbar/appbar.dart';
import '../../../common/widgets/loaders/brands_shimmer.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = Get.put(BrandController());
    return Scaffold(
        appBar: const TAppBar(title: Text('Trending Products')),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                    children: [
                      /// -- Heading
                      const SectionHeading(title: 'Brands', showActionButton: false),
                      const SizedBox(height: TSizes.spaceBtwItems),

                      /// -- Brands
                      Obx(
                              () {
                            if (brandController.isLoading.value) return BrandsShimmer(itemCount: brandController.featuredBrands.length);
                            if (brandController.allBrands.isEmpty) {
                              return Center(
                                  child: Text(
                                      'No Data Found',
                                      style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white)));
                            }

                            return GridLayout(
                              itemCount: brandController.allBrands.length,
                              mainAxisExtent: 80,
                              itemBuilder: (_, index) {
                                final brand = brandController.allBrands[index];
                                return ProductBrandCard(
                                  brand: brand,
                                  showBorder: true,
                                  onTap: () => Get.to(() => BrandsProducts(brand: brand)),
                                );
                              },
                            );
                          }
                      ),
                  ]
                )
            )
        )
    );
  }
}
