import 'package:e_commercial_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import '../../../../utils/constants/colors.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.radius = TSizes.cardRadiusLg,
    this.borderColor = TColors.borderPrimary,
    this.showBorder = false,
    this.backgroundColor = TColors.white,
  });

  final double? width;
  final double? height;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: backgroundColor,
          border: showBorder? Border.all(color: borderColor, width: 2) : null,
      ),
      child: child,
    );
  }
}

