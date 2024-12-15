import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../models/product_model.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return RoundedContainer(
      padding: const EdgeInsets.all(TSizes.md),
      showBorder: true,
      backgroundColor: dark? TColors.white.withOpacity(0.1) : TColors.black.withOpacity(0.05),
      borderColor: dark? TColors.white.withOpacity(0.1) : TColors.black.withOpacity(0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeading(title: 'Product Description', showActionButton: false, textColor: dark? TColors.white : TColors.black),
          const SizedBox(height: TSizes.spaceBtwItems / 2),
          ReadMoreText(
            product.description ?? 'No description provided',
            trimMode: TrimMode.Line,
            trimLines: 2,
            trimCollapsedText: 'Show more ',
            trimExpandedText: ' Show less ',
            moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: TColors.primary),
            lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: TColors.primary),
          ),
        ],
      ),
    );
  }
}
