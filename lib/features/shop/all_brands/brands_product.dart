import 'package:e_commercial_app/common/widgets/appbar/appbar.dart';
import 'package:e_commercial_app/common/widgets/brands/brand_card.dart';
import 'package:e_commercial_app/common/widgets/loaders/vertical_product_shimmer.dart';
import 'package:e_commercial_app/features/shop/controllers/brand_controller.dart';
import 'package:e_commercial_app/features/shop/models/brand_model.dart';
import 'package:e_commercial_app/utils/constants/sizes.dart';
import 'package:e_commercial_app/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/products/sortable/sortable_products.dart';

class BrandsProducts extends StatelessWidget {
  const BrandsProducts({
    super.key,
    required this.brand
  });

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: TAppBar(title: Text(brand.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Brand Details
              ProductBrandCard(showBorder: true, brand: brand),
              const SizedBox(height: TSizes.spaceBtwSections),

              FutureBuilder(
                future: controller.getBrandProducts(brandId: brand.id),
                builder: (context, snapshot) {

                  /// Handle Loader, No Record or Error Message
                  const loader = VerticalProductShimmer();
                  final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                  if (widget != null) return widget;

                  // Record Found!
                  final brandProducts = snapshot.data!;
                  return SortableProducts(products: brandProducts);
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
