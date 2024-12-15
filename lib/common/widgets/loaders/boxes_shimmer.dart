import 'package:e_commercial_app/common/widgets/loaders/shimmer_loader.dart';
import 'package:e_commercial_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class BoxesShimmer extends StatelessWidget {
  const BoxesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(child: ShimmerLoader(height: 110, width: 150)),
            SizedBox(width: TSizes.spaceBtwItems),
            Expanded(child: ShimmerLoader(height: 110, width: 150)),
            SizedBox(width: TSizes.spaceBtwItems),
            Expanded(child: ShimmerLoader(height: 110, width: 150))
          ],
        )
      ],
    );
  }
}
