import 'package:e_commercial_app/common/widgets/loaders/shimmer_loader.dart';
import 'package:e_commercial_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HorizontalProductShimmer extends StatelessWidget {
  const HorizontalProductShimmer({
    super.key,
    this.itemCount = 4
  });

  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwSections),
      height: 120,
      child: ListView.separated(
        itemCount: itemCount,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: TSizes.spaceBtwItems),
        itemBuilder: (_, __) => const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Image
            ShimmerLoader(height: 120, width: 120),
            SizedBox(width: TSizes.spaceBtwItems),

            /// Text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: TSizes.spaceBtwItems / 2),
                ShimmerLoader(height: 15, width: 160),
                SizedBox(height: TSizes.spaceBtwItems / 2),
                ShimmerLoader(height: 15, width: 110),
                SizedBox(height: TSizes.spaceBtwItems / 2),
                ShimmerLoader(height: 15, width: 80),
                Spacer(),
              ],
            )
          ],
        ),

      ),
    );
  }
}
