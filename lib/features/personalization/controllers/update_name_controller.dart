import 'package:e_commercial_app/data/repositories/user/user_repository.dart';
import 'package:e_commercial_app/features/personalization/controllers/user_controller.dart';
import 'package:e_commercial_app/features/personalization/screens/profile/profile.dart';
import 'package:e_commercial_app/utils/constants/image_strings.dart';
import 'package:e_commercial_app/utils/popups/full_screen_loader.dart';
import 'package:e_commercial_app/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../utils/helpers/network_manager.dart';

class UpdateNameController extends GetxController{
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  /// init user data when Name screen appears
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  /// Fetch User Record
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try{
      // Start Loading
      FullScreenLoader.openLoadingDialog('We are updating your information...', TImages.productsSaleIllustration);

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        FullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if(!updateUserNameFormKey.currentState!.validate()){
        FullScreenLoader.stopLoading();
        return;
      }

      // Update User's first and last name in the firebase firestore
      Map<String, dynamic> name = {'FirstName' : firstName.text.trim(), 'LastName' : lastName.text.trim()};
      await userRepository.updateSingleField(name);

      // Update the Rx User values
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show Success Message
      Loaders.successSnackBar(title: "Successful Update", message: "Your name has been updated");

      // Move to previous Screen
      Navigator.pop(Get.overlayContext!);

    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }


}