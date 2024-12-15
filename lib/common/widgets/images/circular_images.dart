import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commercial_app/common/widgets/loaders/shimmer_loader.dart';
import 'package:e_commercial_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';

class CircularImage extends StatelessWidget {
  const CircularImage({
    super.key,
    this.width = 56,
    this.height = 56,
    required this.image,
    this.backgroundColor,
    this.overLayColor,
    this.fit = BoxFit.cover,
    this.padding = TSizes.sm,
    this.isNetworkImage = false,
  });

  final double width, height, padding;
  final String image;
  final Color? backgroundColor;
  final Color? overLayColor;
  final BoxFit? fit;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor?? (dark? TColors.dark : TColors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child:  ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Center(
              child : isNetworkImage? CachedNetworkImage(
              fit: fit,
              color: overLayColor,
              imageUrl: image,
              progressIndicatorBuilder: (context, url, downloadProgress) => const ShimmerLoader(radius: 55, height: 55, width: 55),
              errorWidget: (context, url, downloadProgress) => const Icon(Icons.error),
            )
              : Image(
                  fit: fit,
                  image: AssetImage(image),
                  color: overLayColor,
            ),
          ),
        ),
      )
    );
  }
}

