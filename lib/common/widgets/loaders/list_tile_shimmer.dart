import 'package:e_commercial_app/common/widgets/loaders/shimmer_loader.dart';
import 'package:e_commercial_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ListTileShimmer extends StatelessWidget {
  const ListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            ShimmerLoader(height: 50, width: 50, radius: 50),
            SizedBox(width:  TSizes.spaceBtwItems),
            Column(
              children: [
                ShimmerLoader(height: 15, width: 100),
                SizedBox(height: TSizes.spaceBtwItems / 2),
                ShimmerLoader(height: 12, width: 80),
              ],
            )
          ],
        )
      ],
    );
  }
}
