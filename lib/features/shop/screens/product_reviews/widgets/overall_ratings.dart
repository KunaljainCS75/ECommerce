import 'package:e_commercial_app/features/shop/screens/product_reviews/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';

class OverallProductRatings extends StatelessWidget {
  const OverallProductRatings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: Text('4.8', style: Theme.of(context).textTheme.displayLarge)),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RatingProgressIndicator(text: "5", value: 0.6),
              RatingProgressIndicator(text: "4", value: 0.9),
              RatingProgressIndicator(text: "3", value: 0.7),
              RatingProgressIndicator(text: "2", value: 0.5),
              RatingProgressIndicator(text: "1", value: 0.2),
            ],
          ),
        )
      ],
    );
  }
}
