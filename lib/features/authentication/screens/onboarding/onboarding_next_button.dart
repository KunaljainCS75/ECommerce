import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/onboarding/onboarding_controller.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final dark = THelperFunctions.isDarkMode(context);

    return Positioned(
        right: TSizes.defaultSpace,
        bottom: TDeviceUtils.getBottomNavigationBarHeight() * .25,
        child: ElevatedButton(
          onPressed: () {
            OnBoardingController.instance.nextPage();
            print(OnBoardingController.instance.currentPageIndex);

          },
          style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
              backgroundColor: dark? TColors.primary : Colors.black,
            padding: const EdgeInsets.all(TSizes.defaultSpace / 2),
            
          ),
          child: const Row(
            children: [
              Text('Next'),
              SizedBox(width: TSizes.spaceBtwItems),
              Icon(Iconsax.arrow_right_3),
            ],
          ),
        ));
  }
}
