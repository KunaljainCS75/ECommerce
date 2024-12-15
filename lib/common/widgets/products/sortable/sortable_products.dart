import 'package:e_commercial_app/features/shop/controllers/product/all_products_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../features/shop/models/product_model.dart';
import '../../../../utils/constants/sizes.dart';
import '../../layouts/grid_layout.dart';
import '../product_cards/product_card_vertical.dart';

class SortableProducts extends StatelessWidget {
  const SortableProducts({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    controller.assignProducts(products);
    return Column(
      children: [
        /// Dropdown
        DropdownButtonFormField(
          onChanged: (value) {
            controller.sortProducts(value!);
          },
          value: controller.selectedSortOption.value,
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          items: [
            "Name", "Higher Price", "Lowest Price", "On Sale", "Newest",
          ].map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),

        /// Products
        Obx(() => GridLayout(
              itemCount: controller.products.length,
              itemBuilder: (_, index) => ProductCardVertical(product: controller.products[index])),
        )
      ],
    );
  }
}