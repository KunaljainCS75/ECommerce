import 'package:e_commercial_app/common/widgets/loaders/shimmer_loader.dart';
import 'package:e_commercial_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CategoryShimmerLoader extends StatelessWidget {
  const CategoryShimmerLoader({
    super.key,
    required this.itemCount
  });

  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_,__) => const SizedBox(width: TSizes.spaceBtwItems),
        itemBuilder: (_, __) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Image
              ShimmerLoader(height: 55, width: 55, radius: 55),
              SizedBox(height: TSizes.spaceBtwItems / 2),

              /// Text
              ShimmerLoader(height: 8, width: 55)
            ],
          );
        },
      ),
    );
  }
}
