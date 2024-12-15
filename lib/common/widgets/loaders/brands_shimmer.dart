import 'package:e_commercial_app/common/widgets/layouts/grid_layout.dart';
import 'package:e_commercial_app/common/widgets/loaders/shimmer_loader.dart';
import 'package:flutter/material.dart';

class BrandsShimmer extends StatelessWidget {
  const BrandsShimmer({
    super.key,
    this.itemCount = 4,
    this.height = 300,
    this.width = 80
  });

  final int itemCount;
  final double height, width;
  @override
  Widget build(BuildContext context) {
    return GridLayout(
      mainAxisExtent: 80,
      itemCount: itemCount,
      itemBuilder: (_, __) => ShimmerLoader(height: height, width: width),
    );
  }
}
