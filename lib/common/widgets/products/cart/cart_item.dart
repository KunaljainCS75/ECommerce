import 'package:e_commercial_app/features/shop/models/cart_item_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../images/rounded_images.dart';
import '../../texts/brand_title_text.dart';
import '../../texts/product_title_text.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.cartItem,
  });

  final CartItemModel cartItem;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Image
        RoundedImage(
          imgUrl: cartItem.image ?? '',
          width: 60,
          height: 60,
          isNetworkImage: true,
          // padding: const EdgeInsets.all(TSizes.sm),
          backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.darkerGrey : TColors.light,
        ),
        const SizedBox(width: TSizes.spaceBtwItems),

        /// Title, Price & Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BrandTitleText(title: cartItem.brandName ?? '', maxLines: 1),
              ProductTitleText(title: cartItem.title, maxLines: 1,),

              /// Attributes
              Text.rich(
                  TextSpan(
                      children: (cartItem.selectedVariation ?? {}).entries.map(
                              (e) => TextSpan(
                                children: [
                                  TextSpan(text: ' ${e.key}' , style: Theme.of(context).textTheme.bodySmall),
                                  TextSpan(text: ' ${e.value} ', style: Theme.of(context).textTheme.bodyLarge),
                                ]
                              )
                      ).toList()
                  )
              )
            ],
          ),
        )
      ],
    );
  }
}
