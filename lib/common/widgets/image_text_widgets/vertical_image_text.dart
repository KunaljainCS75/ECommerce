import 'package:e_commercial_app/common/widgets/images/circular_images.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class VerticalImageText extends StatelessWidget {
  const VerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = TColors.white,
    this.onTap,
    this.backgroundColor,
    this.isNetworkImage = false,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final bool isNetworkImage;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: TSizes.spaceBtwItems),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue.shade900, width: 2),
                borderRadius: BorderRadius.circular(100)
              ),
              child: CircularImage(
                image: image,
                fit: BoxFit.fitWidth,
                padding: TSizes.sm * 1.4,
                isNetworkImage: isNetworkImage,
                backgroundColor: backgroundColor,
                overLayColor: THelperFunctions.isDarkMode(context) ? TColors.light : TColors.dark,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 8),
            SizedBox(width: 70, child: Center(
              child: Text(title,
                style: Theme.of(context).textTheme.labelMedium!.apply(color: textColor),
                maxLines: 1, overflow: TextOverflow.ellipsis,),
            )),
          ],
        ),
      ),
    );
  }
}










