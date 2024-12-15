import 'package:flutter/material.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 40,
        ),
        Image(
          image: dark
              ? const AssetImage(TImages.darkAppLogo)
              : const AssetImage(TImages.lightAppLogo),
          height: 80,
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          TTexts.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          TTexts.loginSubTitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}


