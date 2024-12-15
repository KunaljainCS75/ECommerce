import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commercial_app/common/widgets/loaders/shimmer_loader.dart';
import 'package:e_commercial_app/features/shop/all_brands/brands_product.dart';
import 'package:e_commercial_app/features/shop/models/brand_model.dart';
import 'package:e_commercial_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../custom_shapes/containers/rounded_container.dart';
import 'brand_card.dart';


class BrandShowCase extends StatelessWidget {
  const BrandShowCase({
    super.key,
    required this.images,
    required this.brand,

  });

  final BrandModel brand;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => BrandsProducts(brand: brand)),
      child: RoundedContainer(
        showBorder: true,
        borderColor: TColors.darkGrey,
        backgroundColor: Colors.transparent,
        margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
        padding: const EdgeInsets.all(TSizes.md),
        child: Column(
            children: [
              /// Brands with Product Count
              ProductBrandCard(brand: brand, showBorder: false,),

              /// Brand Top 3 Product Images
              Row(
                children: images.map((image) => brandTopProductImageWidget(image, context)).toList()
              )
            ]
        ),
      ),
    );
  }

  Widget brandTopProductImageWidget(String image, context) {
    return Expanded(
                child: RoundedContainer(
                  height: 100,
                  borderColor: Colors.black12,
                  showBorder: true,
                  backgroundColor: THelperFunctions.isDarkMode(context)? TColors.white.withOpacity(0.3) : TColors.light,
                  margin: const EdgeInsets.only(right: TSizes.sm),
                  padding: const EdgeInsets.all(TSizes.md),
                  child: CachedNetworkImage(
                    fit: BoxFit.contain,
                    imageUrl: image,
                    progressIndicatorBuilder: (context, url, downloadProgress) => const ShimmerLoader(height: 100, width: 100),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  )
                ),
              );
  }
}