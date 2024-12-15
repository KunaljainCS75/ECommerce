import 'package:e_commercial_app/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commercial_app/data/repositories/user/user_repository.dart';
import 'package:e_commercial_app/data/user/user.dart';
import 'package:e_commercial_app/features/authentication/screens/login/login.dart';
import 'package:e_commercial_app/features/personalization/screens/profile/widget/re_authenticate_user_login_form.dart';
import 'package:e_commercial_app/utils/constants/colors.dart';
import 'package:e_commercial_app/utils/constants/sizes.dart';
import 'package:e_commercial_app/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  final imageUploading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());
  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  // Fetching User Details
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // Save user Record from any Registration Provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      // Refresh user record (to avoid re-storing same record)
      await fetchUserRecord();
      if (user.value.id.isEmpty) {
        if (userCredentials != null) {
          // Convert Name to firstname and lastname
          final nameParts = UserModel.nameParts(userCredentials.user!.displayName ?? '');
          final username = UserModel.generateUsername(userCredentials.user!.displayName ?? '');

          // Map Data
          final user = UserModel(
              id: userCredentials.user!.uid,
              firstName: nameParts[0],
              lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
              username: username,
              phoneNumber: userCredentials.user!.email ?? '',
              email: userCredentials.user!.phoneNumber ?? '',
              profilePicture: userCredentials.user!.photoURL ?? ''
          );

          // Save UserData
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      Loaders.warningSnackBar(
          title: "Data not saved",
          message: "Something went wrong while saving your information. You can re-save your data in your Profile."
      );
    }
  }

  /// Delete Account Warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.md),
      title: 'Delete Account',
      middleText: 'Are you sure that you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently',
      confirm: ElevatedButton(
        onPressed: () async => deleteAccount(),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
        child: const Padding(padding: EdgeInsets.symmetric(horizontal: TSizes.lg), child: Text('Delete')),
      ),
      cancel: ElevatedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        style: ElevatedButton.styleFrom(backgroundColor: TColors.primary, side: const BorderSide(color: TColors.primary)),
        child: const Padding(padding: EdgeInsets.symmetric(horizontal: TSizes.lg), child: Text('Cancel')),
      ),
    );
  }

  /// Delete User Account
  void deleteAccount() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog('We are updating your information...',
          TImages.productsSaleIllustration);

      /// First re-Authenticate user
      final auth = AuthenticationRepository.instance;
      final provider = auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        // Re Verify Auth Email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();

          // Stop Loading
          FullScreenLoader.stopLoading();

          // ReDirect to LoginScreen
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {

          // Stop Loading
          FullScreenLoader.stopLoading();
          Get.off(() => const ReAuthenticateUserLoginForm());
        }
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.warningSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  /// ReAuthenticate Before Deleting
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try{
      // Start Loading
      FullScreenLoader.openLoadingDialog('Deleting your account...', TImages.productsSaleIllustration);

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        FullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if(!reAuthFormKey.currentState!.validate()){
        FullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.reAuthenticateWithEmailAndPassword(verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();

      // Success Message
      Loaders.successSnackBar(title: "Deleted Successfully", message: "Account has been removed permanently.");

      // Remove Loader
      FullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  /// Update User Profile picture
  uploadUserProfilePicture() async {
    try{

    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image != null) {
      imageUploading.value = true;

      // Upload Image
      final imageUrl = await userRepository.uploadImage('Users/Images/Profile/', image);

      // Update User Image Record
      Map<String, dynamic> json = {'ProfilePicture': imageUrl};
      await userRepository.updateSingleField(json);
      user.value.profilePicture = imageUrl;
      user.refresh();

      Loaders.successSnackBar(title: "Profile Picture Changed", message: "Your profile image has been updated...");}
    }
    catch (e) {
      Loaders.warningSnackBar(title: 'Oh Snap', message: "Something went wrong: $e");
    }
    finally {
      imageUploading.value = false;
    }
  }
}

