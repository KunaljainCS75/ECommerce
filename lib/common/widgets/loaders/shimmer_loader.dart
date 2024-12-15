import 'package:e_commercial_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/constants/colors.dart';

class ShimmerLoader extends StatelessWidget {
  const ShimmerLoader({
    super.key,
    required this.height,
    required this.width,
    this.radius = 15,
    this.color
  });

  final double height, width, radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Shimmer.fromColors(
      baseColor: TColors.primary,
      highlightColor: dark? Colors.grey[200]! : Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? (dark? TColors.darkerGrey : TColors.white),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
