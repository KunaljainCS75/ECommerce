import 'package:e_commercial_app/common/widgets/loaders/shimmer_loader.dart';
import 'package:e_commercial_app/features/shop/controllers/category_controller.dart';
import 'package:e_commercial_app/features/shop/screens/sub-categories/sub_categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/image_text_widgets/vertical_image_text.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../category_loader/category_shimmer_loader.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    return Obx(
      () {
        if (categoryController.isLoading.value == true) return const CategoryShimmerLoader(itemCount: 6);
        if (categoryController.featuredCategories.isEmpty){
          return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white)));
        }
        return SizedBox(
          height: 80,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: categoryController.featuredCategories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              final category = categoryController.featuredCategories[index];
              return VerticalImageText(
                  image: category.image,
                  title: category.name,
                  onTap: () => Get.to(() => SubCategoriesScreen(category: category)));
            },
          ),
        );
      },
    );
  }
}