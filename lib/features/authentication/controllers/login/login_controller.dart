import 'package:e_commercial_app/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commercial_app/features/personalization/controllers/user_controller.dart';
import 'package:e_commercial_app/utils/helpers/network_manager.dart';
import 'package:e_commercial_app/utils/popups/full_screen_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/popups/loaders.dart';

class LoginController extends GetxController{

  /// Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey <FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());


  @override
  void onInit() {
    email.text = localStorage.read("REMEMBER_ME_EMAIL")?? "";
    password.text = localStorage.read("REMEMBER_ME_PASSWORD")?? "";
    super.onInit();
  }

  /// Email & Password -- SignIn
  Future <void> emailAndPasswordSignIn() async {
    try{
      // Start Loading
      FullScreenLoader.openLoadingDialog('Logging you in...', TImages.productsSaleIllustration);

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        FullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if(!loginFormKey.currentState!.validate()){
        FullScreenLoader.stopLoading();
        return;
      }

      // Save Data if Remember Me is selected
      if(rememberMe.value){
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Login user with Email & Password Authentication
      final userCredentials = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Remove Loader
      FullScreenLoader.stopLoading();

      // ReDirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }


  /// --- Google SignIn Authentication
  Future<void> googleSignIn()  async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog('Logging you in...', TImages.productsSaleIllustration);

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        FullScreenLoader.stopLoading();
        return;
      }

      // Google Authentication
      final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();

      // Save User Record
      await userController.saveUserRecord(userCredentials);

      // Stop Loading
      FullScreenLoader.stopLoading();

      // ReDirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}