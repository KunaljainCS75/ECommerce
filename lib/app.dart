import 'package:e_commercial_app/bindings/general_bindings.dart';
import 'package:e_commercial_app/routes/app_routes.dart';
import 'package:e_commercial_app/utils/constants/colors.dart';
import 'package:e_commercial_app/utils/theme/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'features/authentication/screens/onboarding/onboarding.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      getPages: AppRoutes.pages,
      home: const Scaffold(backgroundColor: TColors.primary,body: Center(child: CircularProgressIndicator(color: Colors.white)))
    );
  }
}
