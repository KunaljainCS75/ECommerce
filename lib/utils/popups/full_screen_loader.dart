import 'package:e_commercial_app/common/widgets/loaders/animation_loader.dart';
import 'package:e_commercial_app/utils/constants/colors.dart';
import 'package:e_commercial_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullScreenLoader{

  static void openLoadingDialog (String text, String animation){
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => PopScope(
          canPop: false,
          child: Container(
            color: THelperFunctions.isDarkMode(Get.context!) ? TColors.dark : TColors.white,
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Text(text, style: Theme.of(Get.context!).textTheme.titleLarge,)
              ],
            ),
          ),
        )
    );
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}