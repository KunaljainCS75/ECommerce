import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commercial_app/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:e_commercial_app/features/shop/controllers/product/images_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../../common/widgets/icons/circular_icon.dart';
import '../../../../../common/widgets/images/rounded_images.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../models/product_model.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({
    super.key,
    required this.product
  });

  final ProductModel product;


  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    final controller = Get.put(ImagesController());
    final images = controller.getAllProductImages(product);

    return CurvedEdgesWidget(
      child: Container(
        color: dark ? TColors.darkGrey : TColors.light,
        child: Stack(
          children: [
            /// Main Large Image
            SizedBox(
                height: 400,
                child: Padding(
                    padding: const EdgeInsets.all(TSizes.productImageRadius * 2.5),
                    child: Center(child: Obx(() {
                      final image = controller.selectedProductImage.value;
                      return GestureDetector(
                        onTap: () => controller.showEnlargedImage(image),
                        child: CachedNetworkImage(imageUrl: image, progressIndicatorBuilder: (_, __, downloadProgress) =>
                        CircularProgressIndicator(value: downloadProgress.progress, color: TColors.primary)),
                      );
                    }))
                )
            ),

            /// Image Slider
            Positioned(
              left: TSizes.defaultSpace,
              right: TSizes.defaultSpace,
              bottom: 30,
              child: SizedBox(height: 80,
                child: ListView.separated(separatorBuilder: (_, __) => const SizedBox(width: TSizes.spaceBtwItems * 2,),
                    itemCount: images.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (_, index) => Obx(
                      () {
                        final imageSelected = controller.selectedProductImage.value == images[index];
                        return RoundedImage(
                          width: 80,
                          isNetworkImage: true,
                          imgUrl: images[index],
                          backgroundColor: dark ? TColors.dark : TColors.white,
                          padding: const EdgeInsets.all(TSizes.sm),
                          border: Border.all(color: imageSelected? THelperFunctions.isDarkMode(context)? TColors.white: TColors.primary : Colors.transparent),
                          onPressed: () => controller.selectedProductImage.value = images[index],
                        );
                      })),
              ),
            ),
            /// AppBar Icons
            TAppBar(
              showBackArrow: true,
              actions: [FavouriteIcon(productId: product.id)],
            )
          ],
        ),
      ),
    );
  }
}