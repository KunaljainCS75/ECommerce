import 'package:e_commercial_app/utils/device/device_utility.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';

class TaBBar extends StatelessWidget implements PreferredSizeWidget{
  const TaBBar({
    super.key, required this.tabs,
  });

  final List<Widget> tabs;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Material(
      color: dark? TColors.black: TColors.white,
      child: TabBar(
          dividerHeight: 50,
          dividerColor: dark? TColors.white.withOpacity(0.2) : TColors.black.withOpacity(0.2),
          tabs: tabs,
          isScrollable: true,
          splashBorderRadius: BorderRadius.circular(200),
          tabAlignment: TabAlignment.start,
          indicatorColor: TColors.primary,
          labelColor: dark? TColors.white : TColors.black,
          unselectedLabelColor: TColors.darkGrey
          ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}