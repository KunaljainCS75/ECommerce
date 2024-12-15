import 'package:e_commercial_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/device/device_utility.dart';


class StoreAppBar extends StatelessWidget implements PreferredSizeWidget{
  const StoreAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TAppBar(
      showBackArrow: false,
      title: Text('Store', style: Theme.of(context).textTheme.headlineMedium),
      actions: [
        CartCounterAndMenuIcon(iconColor: dark? TColors.white : TColors.dark),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}