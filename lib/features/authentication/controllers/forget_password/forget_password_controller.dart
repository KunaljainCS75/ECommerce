import 'package:e_commercial_app/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:e_commercial_app/utils/popups/full_screen_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/loaders.dart';

class ForgetPasswordController extends GetxController{
  // Instead of using Get.put() to create new instance,
  // by Get.find() we can find already created instance to save memory.
  static ForgetPasswordController get instance => Get.find();

  /// Variables
  final email = TextEditingController();
  GlobalKey <FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  /// Send Reset Password mail
  sendResetPasswordEmail() async {
    try{
      // Start Loading
      FullScreenLoader.openLoadingDialog("Sending reset password mail...", TImages.productsSaleIllustration);

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        FullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if(!forgetPasswordFormKey.currentState!.validate()){
        FullScreenLoader.stopLoading();
        return;
      }

      // Sending email to reset password
      AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show Success Screen
      Loaders.successSnackBar(title: "Email Sent", message: "Email Link to Reset your Password".tr);

      // ReDirect
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));

    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  resendResetPasswordEmail(String email) async {
    try{
      // Start Loading
      FullScreenLoader.openLoadingDialog("Sending reset password mail...", TImages.productsSaleIllustration);

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        FullScreenLoader.stopLoading();
        return;
      }

      // Sending email to reset password
      AuthenticationRepository.instance.sendPasswordResetEmail(email);

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show Success Screen
      Loaders.successSnackBar(title: "Email Sent", message: "Email Link to Reset your Password".tr);

    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}