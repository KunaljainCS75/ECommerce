import 'package:e_commercial_app/data/repositories/user/user_repository.dart';
import 'package:e_commercial_app/features/authentication/screens/login/login.dart';
import 'package:e_commercial_app/features/authentication/screens/onboarding/onboarding.dart';
import 'package:e_commercial_app/features/authentication/screens/signup/verify_email.dart';
import 'package:e_commercial_app/navigation_menu.dart';
import 'package:e_commercial_app/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:e_commercial_app/utils/exceptions/format_exceptions.dart';
import 'package:e_commercial_app/utils/exceptions/platform_exceptions.dart';
import 'package:e_commercial_app/utils/local_storage/storage_utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;
  final userRepository = Get.put(UserRepository());
  /// Get Authenticated User Data
  User? get authUser => _auth.currentUser;

  /// Called from main.dart on app launch
  @override
  void onReady() {
    // Remove the Native Splash Screen
    FlutterNativeSplash.remove();
    // Redirect to appropriate Screen
    screenRedirect();
  }

  screenRedirect() async {
    User? user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        // First, initialize user-specific local storage
        await TLocalStorage.init(user.uid);  // Unique for each user = user.uid

        Get.offAll(() => const NavigationMenu());
      }
      else {
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
      }
    } else {
      // Local Storage (Fetch)
      deviceStorage.writeIfNull('isFirstTime', true);

      // Check if it is first time, user opening the app...
      deviceStorage.read('isFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(const OnBoardingScreen());
    }
  }

  /* ------------------------------------ Email & Password sign-in --------------------------------------- */

  /// [EmailAuthentication] - LOGIN
  Future <UserCredential> loginWithEmailAndPassword (String email, String password) async {
    try{
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch(_) {
      throw const TFormatException();
    } on PlatformException catch(e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [EmailAuthentication] - REGISTER
  Future <UserCredential> registerWithEmailAndPassword (String email, String password) async {
    try{
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch(_) {
      throw const TFormatException();
    } on PlatformException catch(e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [EmailVerification] - MAIL VERIFICATION
  Future <void> sendEmailVerification() async {
    try{
      return await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch(e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch(_) {
      throw const TFormatException();
    } on PlatformException catch(e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [EmailAuthentication] - FORGET PASSWORD
  Future <void> sendPasswordResetEmail(String email) async {
    try{
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch(e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch(_) {
      throw const TFormatException();
    } on PlatformException catch(e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [ReAuthenticate] - ReAuthenticate User
  Future <void> reAuthenticateWithEmailAndPassword(String email, String password) async {
    try{
      // Create a credential
      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);

      // ReAuthenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch(e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch(_) {
      throw const TFormatException();
    } on PlatformException catch(e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  /* ------------------------------------ Federated Identity & Social sign-in ---------------------------- */

  /// [GoogleAuthentication] - GOOGLE
  Future<UserCredential> signInWithGoogle() async {
    try{
      // Trigger Authentication Flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;

      // Create a new credential
      final credentials = GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      // Once Signed In, return the User credentials
      return await _auth.signInWithCredential(credentials);

    } on FirebaseAuthException catch(e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch(_) {
      throw const TFormatException();
    } on PlatformException catch(e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [FacebookAuthentication] - FACEBOOK


  /* ------------------------------------ ./end Federated Identity & Social sign-in ---------------------- */

  /// [LogOutUser] - Valid for any authentication
  Future <void> logout() async {
    try{
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch(e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch(_) {
      throw const TFormatException();
    } on PlatformException catch(e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [DeleteUser] - Remove user Auth and FireStore Account
  Future <void> deleteAccount() async {
    try{
      await userRepository.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch(e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch(_) {
      throw const TFormatException();
    } on PlatformException catch(e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

}
