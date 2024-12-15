import 'package:e_commercial_app/utils/constants/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app.dart';
import 'data/repositories/authentication/authentication_repository.dart';
import 'firebase_options.dart';

/// ---- ENTRY POINT OF FLUTTER APP ----
Future<void> main() async {



  /// -- Add Widgets Binding
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// -- GetX Local Storage
  await GetStorage.init();

  /// --  Await Native Splash until other Items Load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  /// -- Initialize Firebase &  Authentication
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
      (FirebaseApp value) => Get.put(AuthenticationRepository())
  );

  /// -- Load all Material Designs / Themes / Localizations / bindings etc.
  runApp(const App());
}


