import 'package:e_commercial_app/features/shop/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_functions.dart';

class SearchBarContainer extends StatelessWidget {
  const SearchBarContainer({
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

    return Padding(
      padding: padding,
      child: InkWell(
        child: Container(
          width: TDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(TSizes.md),
          decoration: BoxDecoration(
              color: showBackground? (dark? TColors.dark : TColors.light) : Colors.transparent,
              borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
              border: showBorder? Border.all(color : TColors.grey) : null
          ),
          child: Row(
            children: [
              Icon(icon, color: dark? TColors.light: TColors.darkerGrey),
              const SizedBox(width: TSizes.spaceBtwItems),
              Text(text, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
        onTap: () => Get.to(() => const SearchScreen(text: "Find...",)),
      ),
    );
  }
}