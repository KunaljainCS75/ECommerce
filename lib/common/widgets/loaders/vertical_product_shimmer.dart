import 'package:e_commercial_app/common/widgets/layouts/grid_layout.dart';
import 'package:e_commercial_app/common/widgets/loaders/shimmer_loader.dart';
import 'package:e_commercial_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class VerticalProductShimmer extends StatelessWidget {
  const VerticalProductShimmer({
    super.key,
    this.itemCount = 4
  });

  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return GridLayout(
      itemCount: itemCount,
      itemBuilder: (_, __) => const SizedBox(
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image
            ShimmerLoader(height: 180, width: 180),
            SizedBox(height: TSizes.spaceBtwItems),

            /// Text
            ShimmerLoader(height: 15, width: 160),
            SizedBox(height: TSizes.spaceBtwItems / 2),
            ShimmerLoader(height: 15, width: 110),
          ],
        ),
      ),
    );
  }
}
