import 'package:e_commercial_app/features/personalization/screens/settings/settings.dart';
import 'package:e_commercial_app/features/shop/screens/cart/cart.dart';
import 'package:e_commercial_app/features/shop/screens/checkout/checkout.dart';
import 'package:e_commercial_app/features/shop/screens/home/home.dart';
import 'package:e_commercial_app/features/shop/screens/orders/order_screen.dart';
import 'package:e_commercial_app/features/shop/screens/product_details/product_details.dart';
import 'package:e_commercial_app/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:e_commercial_app/features/shop/screens/store/store.dart';
import 'package:e_commercial_app/routes/routes.dart';
import 'package:get/get.dart';

class AppRoutes{
  static final pages = [
    GetPage(name: Routes.home, page: () => const HomeScreen()),
    GetPage(name: Routes.store, page: () => const StoreScreen()),
    // GetPage(name: Routes.favourites, page: () => const FavouritesScreen()),
    GetPage(name: Routes.settings, page: () => const SettingScreen()),
    GetPage(name: Routes.productReviews, page: () => const ProductReviewsScreen()),
    GetPage(name: Routes.order, page: () => const OrderScreen()),
    GetPage(name: Routes.checkout, page: () => const CheckOutScreen()),
    GetPage(name: Routes.cart, page: () => const CartScreen()),
    // GetPage(name: Routes.productDetails, page: () => const ProductDetailsScreen()),
  ];
}