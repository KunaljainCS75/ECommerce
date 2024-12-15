import 'package:e_commercial_app/data/repositories/product/product_repository.dart';
import 'package:get/get.dart';
import '../../../data/repositories/brands/brand_repository.dart';
import '../../../utils/popups/loaders.dart';
import '../models/brand_model.dart';
import '../models/product_model.dart';

class BrandController extends GetxController{
  static BrandController get instance => Get.find();

  final RxList<BrandModel> allBrands =  <BrandModel>[].obs;
  final RxList<BrandModel> featuredBrands =  <BrandModel>[].obs;
  RxBool isLoading = false.obs;

  final brandRepository = Get.put(BrandRepository());

  @override
  void onInit() {
    getFeaturedBrands();
    super.onInit();
  }

  /// Load Brands
  Future <void> getFeaturedBrands() async {
    try {
      // Show loader while loading brands
      isLoading.value = true;

      final brands = await brandRepository.getAllBrands();

      allBrands.assignAll(brands);


      featuredBrands.assignAll(allBrands.where((brand) => brand.isFeatured ?? false).take(4));

    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      // Stop Loader
      isLoading.value = false;
    }
  }

  /// Get Brands for category
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      final brands = await BrandRepository.instance.getBrandsForCategory(categoryId);
      return brands;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  /// Get Brand Specific products only
  Future<List<ProductModel>> getBrandProducts({required String brandId, int limit = -1}) async {
    try {
      final products = await ProductRepository.instance.getProductsForBrand(brandId: brandId, limit: limit);
      return products;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }
}