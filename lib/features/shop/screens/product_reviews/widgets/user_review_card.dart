import 'package:e_commercial_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_commercial_app/features/shop/screens/product_reviews/widgets/rating_stars_indicator.dart';
import 'package:e_commercial_app/utils/constants/colors.dart';
import 'package:e_commercial_app/utils/constants/sizes.dart';
import 'package:e_commercial_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../../../utils/constants/image_strings.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(backgroundImage: AssetImage(TImages.user)),
                const SizedBox(width: TSizes.spaceBtwItems),
                Text("John Boe", style: Theme.of(context).textTheme.titleLarge)
              ],
            ),
            IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert))
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),


        /// Review
        Row(
          children: [
            const RatingStarIndicator(rating: 4),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text("01 Nov, 2024", style: Theme.of(context).textTheme.bodyMedium)
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        const ReadMoreText(
            trimLines: 2, trimMode: TrimMode.Line,
            trimExpandedText: ' show less ', trimCollapsedText: ' show more ',
            lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: TColors.primary),
            moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: TColors.primary),
            "I am enjoying this app very much. The user Interface of this app is quite beneficial and user-friendly, it is very smooth and interactive. Everything in this app is easily navigable. Great Job!!!, "
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        /// Company Review
        RoundedContainer(
          backgroundColor: dark? TColors.darkGrey : TColors.grey,
          child: Padding(
            padding: const EdgeInsets.all(TSizes.md),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Kroma Store", style: Theme.of(context).textTheme.titleMedium),
                    Text("02 Nov, 2024", style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                const ReadMoreText(
                    trimLines: 2, trimMode: TrimMode.Line,
                    trimExpandedText: ' show less ', trimCollapsedText: ' show more ',
                    lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: TColors.primary),
                    moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: TColors.primary),
                    "I am enjoying this app very much. The user Interface of this app is quite beneficial and user-friendly, it is very smooth and interactive. Everything in this app is easily navigable. Great Job!!!, "
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
