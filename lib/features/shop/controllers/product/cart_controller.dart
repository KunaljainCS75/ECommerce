import 'package:e_commercial_app/features/shop/controllers/product/variation_controller.dart';
import 'package:e_commercial_app/features/shop/models/cart_item_model.dart';
import 'package:e_commercial_app/features/shop/models/product_model.dart';
import 'package:e_commercial_app/utils/local_storage/storage_utility.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/enums.dart';
import '../../../../utils/popups/loaders.dart';

class CartController extends GetxController{
  static CartController get instance => Get.find();

  /// Variables
  RxInt noOfCartItems = 0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final variationController = VariationController.instance;

  CartController() {
    loadCartItems();
  }

  // Add Items in Cart
  void addToCart(ProductModel product){
    // Quantity Check
    if (productQuantityInCart.value < 1){
      Loaders.customToast(message: 'Select Quantity');
      return;
    }

    // Variation
    if (product.productType ==  ProductType.variable.toString() && variationController.selectedVariation.value.id.isEmpty){
      Loaders.customToast(message: 'Select a Variation');
      return;
    }

    // Stock
    if (product.productType == ProductType.variable.toString()) {
      if (variationController.selectedVariation.value.stock < 1) {
        Loaders.warningSnackBar(message: 'Select Variation is out of Stock', title: 'Oh! Snap');
        return;
      }
    } else {
      if (product.stock < 1) {
        Loaders.warningSnackBar(message: 'Select Variation is out of Stock', title: 'Oh! Snap');
        return;
      }
    }

    // Convert ProductModel to CartItemModel with quantity
    final selectedCartItem = convertToCartItemModel(product, productQuantityInCart.value);

    // Check if already added in Cart
    int index = cartItems
        .indexWhere((cartItem) => cartItem.productId == selectedCartItem.productId
                               && cartItem.variationId == selectedCartItem.variationId);

    if (index >= 0) {
      // Item already added
      cartItems[index].quantity = selectedCartItem.quantity;
    } else {
      cartItems.add(selectedCartItem);
    }

    updateCart();
    Loaders.customToast(message: "Added to Cart successfully.");
  }

  /// Function to Convert Product Model to Cart Model
  CartItemModel convertToCartItemModel(ProductModel product, int quantity) {
    if (product.productType == ProductType.single.toString()) {
      // Reset variation in single product case
      variationController.resetSelectedAttributes();
    }

    final variation = variationController.selectedVariation.value;
    final isVariation = variation.id.isNotEmpty;
    final price = isVariation
                    ? variation.salePrice > 0.0
                          ? variation.salePrice
                          : variation.price
                    : product.salePrice > 0.0
                          ? product.salePrice
                          : product.price;

    return CartItemModel(
      productId: product.id,
      title: product.title,
      price: price,
      quantity: quantity,
      variationId: variation.id,
      image: isVariation ? variation.image : product.thumbnail,
      brandName: product.brand != null ? product.brand!.name : '',
      selectedVariation: isVariation ? variation.attributeValues : null
    );
  }


  /// Update Cart Values
  void updateCart() {
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  void updateCartTotals() {
    double calculatedTotalPrice = 0.0;
    int calculatedNoOfItems = 0;

    for (var item in cartItems) {
      calculatedTotalPrice += item.price * item.quantity.toDouble();
      calculatedNoOfItems += item.quantity;
    }

    totalCartPrice.value = calculatedTotalPrice;
    noOfCartItems.value = calculatedNoOfItems;
  }

  void saveCartItems() {
    final cartItemStrings = cartItems.map((item) => item.toJson()).toList();
    TLocalStorage.instance().saveData('cartItems', cartItemStrings);
  }

  void loadCartItems() {
    final cartItemStrings = TLocalStorage.instance().readData<List<dynamic>>('cartItems');
    if (cartItemStrings != null) {
      cartItems.assignAll(cartItemStrings.map((item) => CartItemModel.fromJson(item as Map<String, dynamic>)));
      updateCartTotals();
    }
  }

  int getProductQuantityInCart(String productId) {
    final foundItem = cartItems.where((item) => item.productId == productId).fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundItem;
  }

  int getPVariationQuantityInCart(String productId, String variationId) {
    final foundItem = cartItems.firstWhere(
            (item) => item.productId == productId && item.variationId == variationId,
        orElse: () => CartItemModel.empty()
    );
    return foundItem.quantity;
  }

  void addOneToCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) => cartItem.productId == item.productId && cartItem.variationId == item.variationId);

    if (index >= 0) {
      cartItems[index].quantity += 1;

    } else {
      cartItems.add(item);
    }
    updateCart();
  }

  void removeOneFromCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) => cartItem.productId == item.productId && cartItem.variationId == item.variationId);

    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        cartItems[index].quantity == 1 ? removeFromCartDialog(index) : cartItems.removeAt(index);
      }
      updateCart();
    }
  }

  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: "Remove Product",
      middleText: "Are you sure, you want to remove this product from cart?",
      onConfirm: () {
        cartItems.removeAt(index);
        updateCart();
          Loaders.customToast(message: "Product removed from the cart");
          Get.back();
      },
      onCancel: () => () => Get.back()
    );
  }

  void updateAlreadyAddedProductCount(ProductModel product) {
    // If product has no variations then show total number of entries of that product in cart
    // Else make default entries to '0' and show cartEntries when variation is selected

    if (product.productType == ProductType.single.toString()) {
      productQuantityInCart.value = getProductQuantityInCart(product.id);
    } else {
      // Get selected variations if any...
      final variationId = variationController.selectedVariation.value.id;
      if (variationId.isNotEmpty) {
        productQuantityInCart.value = getPVariationQuantityInCart(product.id, variationId);
      } else {
        productQuantityInCart.value = 0;
      }
    }
  }
  void clearCart() {
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }
}