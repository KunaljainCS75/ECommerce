import 'package:e_commercial_app/common/widgets/appbar/appbar.dart';
import 'package:e_commercial_app/features/shop/controllers/product/product_controller.dart';
import 'package:e_commercial_app/features/shop/models/product_model.dart';
import 'package:e_commercial_app/utils/helpers/helper_functions.dart';
import 'package:e_commercial_app/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/loaders/vertical_product_shimmer.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.padding = const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final EdgeInsetsGeometry padding;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final searchText = TextEditingController();
    final controller = ProductController.instance;
    bool isSearch = false;
    return Scaffold(
      // backgroundColor: Colors.blue,
      appBar: const TAppBar(
        title: Text("Search Products by Name"), isColor: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
          child: Column(
            children: [
              Container(
                width: TDeviceUtils.getScreenWidth(context),
                padding: const EdgeInsets.all(TSizes.sm / 2),
                decoration: BoxDecoration(
                    color: showBackground? (dark? TColors.dark : TColors.light) : Colors.transparent,
                    borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                    border: showBorder? Border.all(color : TColors.darkerGrey) : null
                ),
                child: Row(
                  children: [
                    const SizedBox(width: TSizes.spaceBtwItems),
                    Icon(icon, color: dark? TColors.light: TColors.darkerGrey),
                    const SizedBox(width: TSizes.spaceBtwItems),
                    Flexible(
                      child: TextField(
                          controller: searchText,
                          style: Theme.of(context).textTheme.titleMedium,
                        decoration: InputDecoration(
                          hintText: text,
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                        ),
                        onSubmitted: (value) {
                            if (searchText.text.length >= 4) {
                              isSearch = true;
                              controller.fetchProductsByName(searchText.text);
                            } else {
                              Loaders.warningSnackBar(title: "Blank Search", message: "Search word length should be at least 4 characters long.");
                            }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              if (isSearch) const Text("Results for your search"),
              if (isSearch) const SizedBox(height: TSizes.spaceBtwItems),
              Obx(() {

                // if (controller.isLoading.value) return const VerticalProductShimmer();
                return GridLayout(
                    itemCount: controller.searchProducts.length,
                    itemBuilder: (_, index) =>
                        ProductCardVertical(product: controller.searchProducts[index])
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
