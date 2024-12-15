import 'package:e_commercial_app/features/shop/controllers/product/favourites_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../icons/circular_icon.dart';

class FavouriteIcon extends StatelessWidget {
  const FavouriteIcon({
    super.key,
    required this.productId
  });

  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouritesController());
    return Obx(
            () => CircularIcon(
              size: 20,
              height: 35,
              width: 35,
              icon: controller.isFavourite(productId) ? Iconsax.heart5 : Iconsax.heart,
              color: controller.isFavourite(productId)? Colors.red : null,
              onPressed: () => controller.toggleFavouriteProduct(productId),
            )
    );
  }
}
