import 'package:e_commercial_app/utils/constants/colors.dart';
import 'package:e_commercial_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimationLoader extends StatelessWidget {
  const AnimationLoader({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed
  });

  final String text;                    /// The text to be displayed below animation
  final String animation;               /// The path of lottie animation file
  final bool showAction;                /// Whether to show action button below the text
  final String? actionText;             /// The text to be displayed on action button
  final VoidCallback? onActionPressed;  /// Callback function to be executed when the action button is pressed

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Lottie.asset(animation, width: MediaQuery.of(context).size.width * 0.8),
          const SizedBox(height: TSizes.defaultSpace),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: TSizes.defaultSpace),
          showAction
              ? SizedBox(width: 250, child: OutlinedButton(
                   onPressed: onActionPressed,
                   style: OutlinedButton.styleFrom(backgroundColor: TColors.dark),
                   child: Text(
                      actionText!,
                      style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.light),
                    ),
                ),
          ) : const SizedBox()
        ],
      ),
    );
  }
}
