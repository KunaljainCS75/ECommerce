import 'package:flutter/material.dart';
import '../../../utils/constants/sizes.dart';
import '../products/product_cards/product_card_vertical.dart';


class GridLayout extends StatelessWidget {
  const GridLayout({
    super.key,
    this.mainAxisExtent = 280,
    required this.itemCount,
    required this.itemBuilder,
  });

  final int itemCount;
  final double? mainAxisExtent;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: itemCount,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: TSizes.gridViewSpacing,
            crossAxisSpacing: TSizes.gridViewSpacing,
            mainAxisExtent: mainAxisExtent
        ),
        itemBuilder: itemBuilder
    );
  }
}
