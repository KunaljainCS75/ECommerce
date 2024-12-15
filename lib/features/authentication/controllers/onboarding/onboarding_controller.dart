import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../screens/login/login.dart';

class OnBoardingController extends GetxController{
  static OnBoardingController get instance => Get.find();

  /// Variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;      // Integer type (state changing variable within stateless widget)

  /// Update Current Index whe Page Scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;

  /// Jump to the specific dot selected page
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
  }

  /// Update Current Index & jump to next page
  void nextPage() {
    if (currentPageIndex.value == 2){
      final storage = GetStorage();
      storage.write('isFirstTime', false);
      Get.offAll(const LoginScreen());
    }
    else{
      int page = currentPageIndex.value + 1;
      pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Update Current Index & jump to last page
  void skipPage() {
    currentPageIndex.value = 2;
    pageController.animateToPage(
      2,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}