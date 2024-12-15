import 'dart:convert';

import 'package:e_commercial_app/data/repositories/product/product_repository.dart';
import 'package:e_commercial_app/features/shop/models/product_model.dart';
import 'package:e_commercial_app/utils/local_storage/storage_utility.dart';
import 'package:e_commercial_app/utils/popups/loaders.dart';
import 'package:get/get.dart';

class FavouritesController extends GetxController{
  static FavouritesController get instance => Get.find();

  /// Variables
  final favourites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initFavourites();
  }

  Future<void> initFavourites() async {
    final json = TLocalStorage.instance().readData('favourites');
    if (json != null) {
      final storedFavourites = jsonDecode(json) as Map<String, dynamic>;
      favourites.assignAll(storedFavourites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavourite(String productId) {
    return favourites[productId] ?? false; // when products is not inside favourites list...it returns null which we call false
  }

  void toggleFavouriteProduct(String productId) {
    if (!favourites.containsKey(productId)) {
      favourites[productId] = true;
      saveFavouritesToStorage();
      Loaders.customToast(message: "Product has been added to the Wishlist");
    } else {
      TLocalStorage.instance().readData(productId);
      favourites.remove(productId);
      saveFavouritesToStorage();
      favourites.refresh();
      Loaders.customToast(message: "Product has been removed from the Wishlist");
    }
  }

  void saveFavouritesToStorage() {
    final encodedFavourites = json.encode(favourites);
    TLocalStorage.instance().saveData("favourites", encodedFavourites);
  }

  Future<List<ProductModel>> favouriteProducts() async {
    return await ProductRepository.instance.getFavouriteProducts(favourites.keys.toList());
  }

}