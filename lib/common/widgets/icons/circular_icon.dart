import 'package:e_commercial_app/utils/constants/sizes.dart';
import 'package:e_commercial_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';

class CircularIcon extends StatelessWidget {
  const CircularIcon({
    super.key,
    required this.icon,
    this.width,
    this.height,
    this.size = TSizes.lg,
    this.color,
    this.backgroundColor,
    this.onPressed,
  });
  /// Containers property: [height], [width], & [backgroundColor],
  /// Icons: [size], [color], [onPressed]

  final double? width, height, size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;



  @override
  Widget build(BuildContext context) {
    final bool dark = THelperFunctions.isDarkMode(context);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: (backgroundColor != null)? (backgroundColor!) : (dark? TColors.black.withOpacity(0.9) : TColors.white.withOpacity(0.9)),
      ),
      child: Center(child: IconButton(onPressed: onPressed,icon: Icon(icon, color: color, size: size))),
    );
  }
}