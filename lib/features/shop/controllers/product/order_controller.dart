import 'package:e_commercial_app/common/widgets/login_signUp/success_screen.dart';
import 'package:e_commercial_app/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commercial_app/features/shop/controllers/product/cart_controller.dart';
import 'package:e_commercial_app/navigation_menu.dart';
import 'package:e_commercial_app/utils/constants/enums.dart';
import 'package:e_commercial_app/utils/constants/image_strings.dart';
import 'package:e_commercial_app/utils/popups/full_screen_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/order/order_repository.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../personalization/controllers/address_controller.dart';
import '../../models/order_model.dart';
import 'checkout_controller.dart';

class OrderController extends GetxController{
  static OrderController get instance => Get.find();

  /// Variables
  final cartController = CartController.instance;
  final addressController = Get.put(AddressController());
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

  /// Fetch User Order History
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      Loaders.warningSnackBar(title: "Oh! Snap", message: e.toString());
      return [];
    }
  }

  /// Add methods for Order Processing
  void processOrder(double totalAmount) async {
    try {
      FullScreenLoader.openLoadingDialog("Processing your Order", TImages.productImage1);

      final userId = AuthenticationRepository.instance.authUser?.uid;
      if (userId!.isEmpty) return;

      final order = OrderModel(
        id: UniqueKey().toString(),
        userId: userId,
        status: OrderStatus.pending,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        // address: addressController.selectedAddress.value,
        deliveryDate: DateTime.now().add(const Duration(days: 7)),
        items: cartController.cartItems.toList()
      );
      await orderRepository.saveOrder(order, userId);
      cartController.clearCart();

      Get.off(() => SuccessScreen(
        image: TImages.staticSuccessIllustration,
        title: 'Payment Success',
        subtitle: "Your item will be shipped soon!",
        onPressed: () => Get.offAll(() => const NavigationMenu()),
      ));
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh! Snap', message: e.toString());
    }
  }
}