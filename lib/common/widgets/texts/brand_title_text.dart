import 'package:e_commercial_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';

class BrandTitleText extends StatelessWidget {
  const BrandTitleText({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.insertIcon = true,
    this.icon = Icons.verified_user_rounded,
    this.color,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
    this.iconColor = TColors.primary,
    this.iconSize = TSizes.md
  });

  final String title;
  final int maxLines;
  final bool insertIcon;
  final IconData icon;
  final Color? color, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          textAlign: textAlign,
          overflow: TextOverflow.ellipsis,
          maxLines: maxLines,
          style: brandTextSize == TextSizes.small
              ? Theme.of(context).textTheme.labelMedium!.apply(color: color, fontWeightDelta: 5)
              : brandTextSize == TextSizes.medium
                 ? Theme.of(context).textTheme.bodyLarge!.apply(color: color, fontWeightDelta: 5)
                 : brandTextSize == TextSizes.large
                    ? Theme.of(context).textTheme.titleLarge!.apply(color: color, fontWeightDelta: 5)
                    : Theme.of(context).textTheme.bodyMedium!.apply(color: color, fontWeightDelta: 5)
        ),
        insertIcon? Row(
          children: [
            const SizedBox(width: TSizes.xs),
            Icon(icon, color: iconColor, size: iconSize)
          ],
        ) : Container()
      ],
    );
  }
}
