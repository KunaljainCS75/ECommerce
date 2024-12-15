import 'package:e_commercial_app/features/personalization/controllers/user_controller.dart';
import 'package:e_commercial_app/utils/constants/sizes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/loaders/shimmer_loader.dart';
import '../../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class ThemeAppBar extends StatelessWidget {
  const ThemeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(UserController());
    return const TAppBar(
      showBackArrow: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.shopping_basket_rounded, size: 35, color: Colors.white),
              SizedBox(width: TSizes.spaceBtwItems / 4),
              Text(TTexts.homeAppbarTitle,
                  style: TextStyle(fontSize: 30, color: Colors.white)),
            ],
          ),

          // Obx(() {
          //   if (controller.profileLoading.value){
          //     // Display a Shimmer Loader
          //     return const Padding(
          //       padding: EdgeInsets.only(top: 16),
          //       child: ShimmerLoader(height: 15, width: 200),
          //     );
          //   }
          //   return Text(controller.user.value.fullName.trim(), style: !dark? Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white) : Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white, fontSizeFactor: .75, fontWeightDelta: 2));
          // }),
        ],
      ),
      actions: [
        CartCounterAndMenuIcon(iconColor: TColors.white),
      ],
    );
  }
}