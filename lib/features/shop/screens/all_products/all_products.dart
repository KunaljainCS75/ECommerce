import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commercial_app/common/widgets/appbar/appbar.dart';
import 'package:e_commercial_app/common/widgets/loaders/vertical_product_shimmer.dart';
import 'package:e_commercial_app/common/widgets/products/sortable/sortable_products.dart';
import 'package:e_commercial_app/features/shop/controllers/product/all_products_controller.dart';
import 'package:e_commercial_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../models/product_model.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key,
    required this.title,
    this.query,
    this.futureMethod
  });

  //2010000000425970

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());

    return Scaffold(
      /// AppBar
      appBar: const TAppBar(title: Text('Trending Products')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: FutureBuilder(
          future: futureMethod ?? controller.fetchProductByQuery(query),
          builder: (context, snapshot) {
            // Loader till operations are completed
            const loader = VerticalProductShimmer();
            final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);

            // Return appropriate widget based on current snapshot state
            if (widget != null) return widget;

            // Products Found!
            final products = snapshot.data!;
            return SortableProducts(products: products);
          }
        ),
      ),
    );
  }
}
