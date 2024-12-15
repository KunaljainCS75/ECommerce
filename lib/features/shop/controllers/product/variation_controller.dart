

import 'dart:async';

import 'package:e_commercial_app/features/shop/controllers/product/cart_controller.dart';
import 'package:e_commercial_app/features/shop/controllers/product/images_controller.dart';
import 'package:e_commercial_app/features/shop/models/product_model.dart';
import 'package:e_commercial_app/features/shop/models/product_variations_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  /// Variables
  RxMap selectedAttributes = {}.obs;
  RxString variationStockStatus = ''.obs;
  Rx<ProductVariationModel> selectedVariation = ProductVariationModel.empty().obs;

  /// Select Attribute & Selection
  void onAttributeSelected(ProductModel product, attributeName, attributeValue) {

    // If an attribute is selected..add it in "selectedAttributes"
    final selectedAttributes = Map<String, dynamic>.from(this.selectedAttributes);
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] = attributeValue;

    final selectedVariation = product.productVariations!.firstWhere((variation) =>
        _isSameAttributeValues(variation.attributeValues, selectedAttributes),
        orElse: () => ProductVariationModel.empty(), // to avoid StateError
    );

    // Show the selected variation image as a Main image
    if (selectedVariation.image.isNotEmpty){
      ImagesController.instance.selectedProductImage.value = selectedVariation.image;
    }

    // Show selected variation quantity already in cart.
    if (selectedVariation.id.isNotEmpty) {
      final cartController = CartController.instance;
      cartController.productQuantityInCart.value = cartController.getPVariationQuantityInCart(product.id, selectedVariation.id);
    }

    // Assign selected variation
    this.selectedVariation.value = selectedVariation;

    // Update selected variation stock status
    getProductVariationStockStatus();
  }


  /// Check if selected attributes matches any variation
  bool _isSameAttributeValues(Map<String, dynamic> variationAttributes, Map<String, dynamic> selectedAttributes){

    // if no. of selectedAttributes != no. of variations
    if(variationAttributes.length != selectedAttributes.length) return false;

    // If an attribute value is different..ex => {Green, Small} <=> {Green, Large} ---> Green == Green but large != small
    for (final key in variationAttributes.keys){ /// Check for all variations
      // Attributes[key] = Value (green, red, blue, small, large...)
      if(variationAttributes[key] != selectedAttributes[key]) return false;
    }
    return true;
  }

  /// Check Attribute availability / Stock in variation
  Set <String?> getAttributesAvailabilityVariation (List<ProductVariationModel> variations, String attributeName) {
    // Pass the variations to check which attributes are available and stock is not 0
    final availableVariationAttributeValues = variations.where((variation) =>
        // Check empty (Out of Stock) selectedAttributes
        variation.attributeValues[attributeName] != null
            && variation.attributeValues[attributeName]!.isNotEmpty
            && variation.stock > 0).map((variation) => variation.attributeValues[attributeName]).toSet(); // Fetch all non-empty variations.
    print(availableVariationAttributeValues.toSet());
    return availableVariationAttributeValues;
  }

  String getVariationPrice(){
    return (selectedVariation.value.salePrice > 0 ? selectedVariation.value.salePrice : selectedVariation.value.price).toString();
  }
  /// Check Product Variable Stock Status
  void getProductVariationStockStatus() {
    variationStockStatus.value = selectedVariation.value.stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  /// Reset Selected Attributes when we switch between products
  void resetSelectedAttributes(){
    selectedAttributes.clear();
    variationStockStatus.value = '';
    selectedVariation.value = ProductVariationModel.empty();
  }
}