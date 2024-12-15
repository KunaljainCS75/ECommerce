import 'package:e_commercial_app/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commercial_app/data/repositories/user/user_repository.dart';
import 'package:e_commercial_app/features/authentication/screens/signup/verify_email.dart';
import 'package:e_commercial_app/utils/constants/image_strings.dart';
import 'package:e_commercial_app/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/user/user.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/loaders.dart';

class SignupController extends GetxController{
  static SignupController get instance => Get.find();

  /// Controllers for all input fields
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();

  // Password & Privacy Toggle (show/hide..enable/disable)
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;

  // Form Key for Form Validation
  GlobalKey <FormState> signupFormKey = GlobalKey <FormState>();

  void signup() async {
    try{
        // Check Internet Connectivity
        final isConnected = await NetworkManager.instance.isConnected();
        if (!isConnected) {
          Loaders.warningSnackBar(
              title: 'No Internet connection',
              message: 'Please check your internet connection and try again.'
          );
          return;
        }

        // Form Validation
        if (!signupFormKey.currentState!.validate()) return;

        // Privacy Policy Check
        if (!privacyPolicy.value){
          Loaders.warningSnackBar(
              title: 'Accept Privacy Policy',
              message: 'In order to create account, you must have to read & accept our Privacy Policy & Terms of Use.'
          );
          return;
        }
        // Start Loading
        FullScreenLoader.openLoadingDialog('We are processing your information', TImages.productsIllustration);

        // Register User in the FireBase Authentication
        final userCredential = await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());

        // Save Authenticated User data in FireBase FireStore
        final newUser = UserModel(
          id: userCredential.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          username: username.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          email: email.text.trim(),
          profilePicture: '',
        );

        final userRepository = Get.put(UserRepository());
        userRepository.saveUserRecord(newUser);

        // Remove Loader
        FullScreenLoader.stopLoading();

        // Show success Message
        Loaders.successSnackBar(title: 'Congratulations', message: 'Your Account has been created! Verify email to continue.');

        // Move to verify Email Screen
        Get.to(() => VerifyEmailScreen(email: email.text.trim()));

    } catch(error){
      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show Generic error to user
      Loaders.errorSnackBar(title: 'Oh Snap!', message: error.toString());
    }
  }
}