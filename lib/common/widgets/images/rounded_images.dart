import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class RoundedImage extends StatelessWidget {
  const RoundedImage({
    super.key,
    this.width,
    this.height,
    this.applyImageRadius = false,
    this.border,
    this.backgroundColor,
    this.fit = BoxFit.contain,
    this.padding,
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = TSizes.md,
    required this.imgUrl,
  });

  final double? width, height;
  final String imgUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        padding: padding,
        decoration: BoxDecoration(
          border: border, color: backgroundColor, borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(borderRadius: applyImageRadius? BorderRadius.circular(TSizes.md) : BorderRadius.zero,
              child: Image(image: isNetworkImage? NetworkImage(imgUrl) : AssetImage(imgUrl) as ImageProvider, fit: fit)),
        ),
      ),
    );
  }
}