import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commercial_app/features/shop/models/product_model.dart';
import 'package:e_commercial_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagesController extends GetxController{
  static ImagesController get instance => Get.find();

  /// Variables
  RxString selectedProductImage = ''.obs;

  /// Get All Images from product and variations
  List <String> getAllProductImages(ProductModel product) {

    // Use set to add unique images
    Set<String> images = {};

    // Load Thumbnail image
    images.add(product.thumbnail);

    // Assign thumbnail as Selected Image
    selectedProductImage.value = product.thumbnail;

    // Get all images from the Product Model if not null.
    if (product.images != null){
      images.addAll(product.images!);
    }

    // Get All images from the product variations if not null
    // if (product.productVariations != null || product.productVariations!.isNotEmpty){
    //   images.addAll(product.productVariations!.map((variation) => variation.image));
    // }

    return images.toList();
  }

  /// Show Image Popup
  void showEnlargedImage(String image) {
    Get.to(
      fullscreenDialog: true,
        () => Dialog.fullscreen(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisSize: MainAxisSize.min,
           children: [
             Padding(
               padding: const EdgeInsets.symmetric(vertical: TSizes.defaultSpace * 2, horizontal: TSizes.defaultSpace * 2),
               child: CachedNetworkImage(imageUrl: image),
             ),
             const SizedBox(height: TSizes.spaceBtwSections),
             Align(
               alignment: Alignment.bottomCenter,
               child: SizedBox(
                 width: 150,
                 child: OutlinedButton(onPressed: () => Get.back(), child: const Text('Close')),
               ),
             )
           ],
         ),
        )
    );
  }
}