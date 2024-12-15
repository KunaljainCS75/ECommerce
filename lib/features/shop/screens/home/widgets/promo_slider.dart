import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commercial_app/common/widgets/loaders/shimmer_loader.dart';
import 'package:e_commercial_app/features/shop/controllers/banner_controller.dart';
import 'package:e_commercial_app/utils/constants/colors.dart';
import 'package:e_commercial_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../../common/widgets/images/rounded_images.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/home_controller.dart';

class PromoSlider extends StatelessWidget {
  const PromoSlider({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());

    return Obx(
        () {
          // Loader
          if (controller.isLoading.value) return const ShimmerLoader(height: 190, width: double.infinity);

          // No data found
          if (controller.banners.isEmpty){
            return const Center(child: Text('No Data Found'));
          }

          return Column(
            children: [
              CarouselSlider(
                  options: CarouselOptions(
                    // _ == (we want to give no specific reason in onPageChanged)
                      onPageChanged: (index, _) =>
                          controller.updatePageIndicator(index),
                      viewportFraction: 1),
                  items: controller.banners.map((banner) =>
                      RoundedImage(
                        imgUrl: banner.imgUrl,
                        width: THelperFunctions.screenWidth(),
                        fit: BoxFit.cover,
                        isNetworkImage: true,
                        onPressed: () => Get.toNamed(banner.targetScreen),
                        applyImageRadius: true,)).toList()
              ),
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              Obx(
                    () =>
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < controller.banners.length; i++)
                          CircularContainer(
                            width: 20,
                            height: 4,
                            backgroundColor: controller.carouselCurrentIndex
                                .value == i ? TColors.primary : TColors.grey,
                            margin: const EdgeInsets.only(right: 10),
                          ),
                      ],
                    ),
              )
            ],
          );
        }
    );
  }
}
