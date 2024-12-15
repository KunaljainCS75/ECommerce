
class TPricingCalculator {

  /// -- Calculate Price based on tax and shipping
  static double calculateTotalPrice(double productPrice, String location) {
  double taxRate = getTaxRateForLocation(location);
  double taxAmount = productPrice * taxRate;

  double shippingCost = productPrice > 0 ? getShippingCost(location): 0;

  double totalPrice = productPrice + taxAmount + shippingCost;
  return totalPrice;
  }

  /// -- Calculate shipping cost
  static String calculateShippingCost(double productPrice, String location) {
  double shippingCost = productPrice > 0 ? getShippingCost(location) : 0;
  return shippingCost.toStringAsFixed(2);
  }
  /// -- Calculate tax
  static String calculateTax(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;
  return taxAmount.toStringAsFixed(2);
  }

  static double getTaxRateForLocation(String location) {
  // Lookup the tax rate for the given location from a tax rate database or API.
  // Return the appropriate tax rate.
  return 0.25; // Example tax rate of 10%
  }

  static double getShippingCost(String location) {
  // Lookup the shipping cost for the given location using a shipping rate API.
  // Calculate the shipping cost based on various factors like distance, weight, etc.
    if (location == 'US'){
      return 5.00; // Example shipping cost of $5
    }
    else if (location == 'India'){
      return 300.00;
    }
    else {return 50;}
  }

//   /// -- Sum all cart values and return total amount
//   static double calculateCartTotal(CartModel cart) {
//     return cart.items.map((e) => e.price).fold(0, (previousPrice, currentPrice) => previousPrice + (currentPrice ?? 0));
//   }
}
