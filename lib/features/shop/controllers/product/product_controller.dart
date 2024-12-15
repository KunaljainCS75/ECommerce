import 'package:e_commercial_app/features/shop/models/product_model.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/product/product_repository.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/popups/loaders.dart';

class ProductController extends GetxController{
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  RxList<ProductModel> searchProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  void fetchFeaturedProducts() async {
    try{

      // Show loader while loading products
      isLoading.value = true;

      // Fetch Products
      final products = await productRepository.getFeaturedProducts();

      // Assign Products
      featuredProducts.assignAll(products);

    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

 Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try{
      // Fetch Products
      final products = await productRepository.getAllFeaturedProducts();
      return products;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  void fetchProductsByName(String name) async {
    try{
      searchProducts.clear();
      // Fetch Products
      final products = await productRepository.fetchProductsByName(name);
      searchProducts.assignAll(products);
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// Get the product price or price range for validation
  String getProductPrice(ProductModel product){
    double smallestPrice = double.infinity;
    double largestPrice = 0;

    // If no variation, return simple sale price
    if (product.productType == ProductType.single.toString()){
      return (product.salePrice > 0 ? "${product.salePrice}" : "₹ ${product.price}").toString();
    }
    else {
      // Calculate smallest & Largest prices among variations
      for (var variation in product.productVariations!) {
        // Determine price (sale price or regular price)
        double priceToConsider = variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        // Update smallest & largest prices
        if(priceToConsider < smallestPrice){
          smallestPrice = priceToConsider;
        }
        if(priceToConsider > largestPrice){
          largestPrice = priceToConsider;
        }
      }
      // In case: Smallest price = largest price
      if(smallestPrice.isEqual(largestPrice)){
        return largestPrice.toString();
      } else {
        return '$smallestPrice - ₹ $largestPrice';
      }
    }
  }

  /// Calculate Discount Percentage
  int calculateSalesPercentage(double originalPrice, double? salePrice){
    if(salePrice == null || salePrice <= 0.0) return 0;
    if (originalPrice <= 0) return 0;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.round();
  }

  /// Check Product Stock Status
  String getProductStockStatus(int stock) {
    return stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  bool isProductInStock(int stock) {
    return stock > 0 ? true : false;
  }
}