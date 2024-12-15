import 'package:e_commercial_app/common/widgets/appbar/appbar.dart';
import 'package:e_commercial_app/common/widgets/icons/circular_icon.dart';
import 'package:e_commercial_app/common/widgets/layouts/grid_layout.dart';
import 'package:e_commercial_app/common/widgets/loaders/animation_loader.dart';
import 'package:e_commercial_app/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:e_commercial_app/features/shop/controllers/product/favourites_controller.dart';
import 'package:e_commercial_app/features/shop/screens/home/home.dart';
import 'package:e_commercial_app/navigation_menu.dart';
import 'package:e_commercial_app/utils/constants/sizes.dart';
import 'package:e_commercial_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/loaders/vertical_product_shimmer.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavouritesController.instance;
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: false,
        title: Text('WishList', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          CircularIcon(
            icon: Iconsax.add, onPressed: () => Get.offAll(const NavigationMenu()),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Obx(
              () => FutureBuilder(
                  future: controller.favouriteProducts(),
                  builder: (context, snapshot) {

                    // final emptyWidget = AnimationLoader(
                    //   text: "WishList is Empty...",
                    //   showAction: true,
                    //   actionText: "Try add some",
                    //   onActionPressed: () => Get.off(() => const NavigationMenu()), animation: '',
                    // );

                    final emptyWidget = Container(
                      decoration: BoxDecoration(
                      ),
                      child: SizedBox(
                        height: THelperFunctions.screenHeight() * .75,
                        width: THelperFunctions.screenWidth() ,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("WishList is Empty...", style: TextStyle(fontSize: 25),),
                          ],
                        ),
                      ),
                    );
                    // Loader till operations are completed
                    const loader = VerticalProductShimmer(itemCount: 6);
                    final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader, nothingFound: emptyWidget);

                    // Return appropriate widget based on current snapshot state
                    if (widget != null) return widget;

                    // Records Found!
                    final products = snapshot.data!;
                    return GridLayout(
                        itemCount: products.length,
                        itemBuilder: (_, index) => ProductCardVertical(product: products[index]));
                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
