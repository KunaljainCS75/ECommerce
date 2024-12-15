import 'package:e_commercial_app/common/widgets/appbar/appbar.dart';
import 'package:e_commercial_app/features/shop/screens/product_reviews/widgets/overall_ratings.dart';
import 'package:e_commercial_app/features/shop/screens/product_reviews/widgets/rating_stars_indicator.dart';
import 'package:e_commercial_app/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:e_commercial_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/sizes.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          appBar: const TAppBar(
            title:  Text("Reviews & Ratings"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Ratings and reviews are verified and are from people, who use the same type of device that you use", textAlign: TextAlign.justify),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// Overall Product Ratings
                  const OverallProductRatings(),
                  const RatingStarIndicator(rating: 3.6),
                  Text(" 12,611", style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// User Review List
                  const UserReviewCard()
                ],
              ),
            ),
          )
        );
  }
}




