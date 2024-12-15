import 'dart:async';

import 'package:e_commercial_app/common/widgets/login_signUp/success_screen.dart';
import 'package:e_commercial_app/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commercial_app/utils/constants/image_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/popups/loaders.dart';

class VerifyEmailController extends GetxController{
  static VerifyEmailController get instance => Get.find();

  /// Send E-Mail whenever verify screen appears and set Timer to auto-redirect.
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  /// Send Email Verification link.
  sendEmailVerification() async {
    try{
      await AuthenticationRepository.instance.sendEmailVerification();
      Loaders.successSnackBar(title: 'Email Sent!', message: 'Please check your inbox and verify email.');
    } catch (e){
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  /// Timer to automatic redirect Email Verification.
  setTimerForAutoRedirect(){
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false){
        timer.cancel();
        Get.off(() => SuccessScreen(
          image: TImages.staticSuccessIllustration,
          title: TTexts.yourAccountCreatedTitle,
          subtitle: TTexts.yourAccountCreatedSubTitle,
          onPressed: () => AuthenticationRepository.instance.screenRedirect(),
        ));
      }
    });
  }

  /// Manually Check if email is verified.
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified){
      Get.off(() => SuccessScreen(
        image: TImages.staticSuccessIllustration,
        title: TTexts.yourAccountCreatedTitle,
        subtitle: TTexts.yourAccountCreatedSubTitle,
        onPressed: () => AuthenticationRepository.instance.screenRedirect(),
      ));
    }
  }
}