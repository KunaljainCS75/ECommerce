import 'package:flutter/material.dart';

class PriceText extends StatelessWidget {
  const PriceText({
    super.key,
    this.isLarge = false,
    this.currencySign = '₹ ',
    this.maxLines = 1,
    this.lineThrough = false,
    required this.price,
  });

  final String price, currencySign;
  final int maxLines;
  final bool isLarge;
  final bool lineThrough;

  @override
  Widget build(BuildContext context) {
    return Text(
        currencySign + price,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: isLarge? Theme.of(context).textTheme.headlineSmall!.apply(decoration: lineThrough? TextDecoration.lineThrough : null, color: Colors.green.shade700, fontWeightDelta: 2)
            : Theme.of(context).textTheme.titleLarge!.apply(decoration: lineThrough? TextDecoration.lineThrough : null, color: Colors.green.shade700, fontWeightDelta: 2));
  }
}
