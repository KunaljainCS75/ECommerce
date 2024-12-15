
import 'package:e_commercial_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../controllers/onboarding/onboarding_controller.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: TDeviceUtils.getAppBarHeight(),
        right: 0,
        child: TextButton(
          onPressed: () => OnBoardingController.instance.skipPage(),
          child: Text("Skip", style: Theme.of(context).textTheme.titleMedium!.apply(color: TColors.primary)),
        ));
  }
}