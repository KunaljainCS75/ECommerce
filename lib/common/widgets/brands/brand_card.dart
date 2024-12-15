import 'package:e_commercial_app/features/shop/models/brand_model.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../custom_shapes/containers/rounded_container.dart';
import '../images/circular_images.dart';
import '../texts/brand_title_text.dart';

class ProductBrandCard extends StatelessWidget {
  const ProductBrandCard({
    super.key,
    this.showBorder = true,
    this.isNetworkImage = false,
    this.onTap,
    required this.brand

  });

  final BrandModel brand;
  final bool showBorder;
  final bool isNetworkImage;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: RoundedContainer(
        padding: const EdgeInsets.all(TSizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            /// Icon
            CircularImage(
              isNetworkImage: isNetworkImage,
              image: brand.image,
              backgroundColor: Colors.transparent,
              overLayColor: dark? TColors.white : TColors.black,
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Brand Text:
                  BrandTitleText(title: brand.name, brandTextSize: TextSizes.small),
                  const SizedBox(height: TSizes.spaceBtwItems / 5),
                  Text(
                    "${brand.productsCount ?? 0} products",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                ],
              ),
            ),


            /// -- Text
            const SizedBox(width: 0)
          ],
        ),
      ),
    );
  }
}

