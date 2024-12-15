import 'package:e_commercial_app/utils/constants/colors.dart';
import 'package:e_commercial_app/utils/device/device_utility.dart';
import 'package:e_commercial_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/sizes.dart';


class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar(
      {super.key,
        this.title,
        this.showBackArrow = true,
        this.leadingIcon,
        this.actions,
        this.leadingOnPressed,
        this.isColor = false
      });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final bool isColor;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Padding(padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
        child: AppBar(
          forceMaterialTransparency: true,
          automaticallyImplyLeading: false,
          leading: showBackArrow?
            IconButton(onPressed: () => Get.back(), icon: const Icon(Iconsax.arrow_left), color: isColor ? TColors.dark : dark? TColors.dark : Colors.white):
            leadingIcon != null ? IconButton(onPressed: leadingOnPressed, icon: Icon(leadingIcon)) : null,

          title: title,
          actions: actions,
        )
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
