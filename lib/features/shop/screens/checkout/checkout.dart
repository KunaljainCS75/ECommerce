import 'package:e_commercial_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_commercial_app/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:e_commercial_app/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:e_commercial_app/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:e_commercial_app/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:e_commercial_app/utils/constants/colors.dart';
import 'package:e_commercial_app/utils/constants/sizes.dart';
import 'package:e_commercial_app/utils/helpers/helper_functions.dart';
import 'package:e_commercial_app/utils/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/products/cart/coupon.dart';
import '../../../../utils/popups/loaders.dart';
import '../../controllers/product/cart_controller.dart';
import '../../controllers/product/order_controller.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final cartController = CartController.instance;
    final orderController = Get.put(OrderController());
    final subTotal = cartController.totalCartPrice.value;
    final totalAmount = TPricingCalculator.calculateTotalPrice(subTotal, "India");
    return Scaffold(
      appBar: TAppBar(title: Text('Order Review', style: Theme.of(context).textTheme.headlineSmall)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Items in Cart
              const CartItems(showAddRemoveButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Coupon TextField
              const CouponCode(),
              const SizedBox(height: TSizes.spaceBtwSections),
              
              /// Billing Section
              RoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: dark? TColors.black : TColors.white,
                child: const Column(
                  children: [
                    /// Pricing
                    BillingAmountSection(),
                    SizedBox(height: TSizes.spaceBtwItems),
                    
                    /// Divider
                    Divider(),
                    SizedBox(height: TSizes.spaceBtwItems),
                    
                    /// Payment Method
                    BillingPaymentSection(),
                    SizedBox(height: TSizes.spaceBtwItems),
                    
                    /// Addresses
                    BillingAddressSection()
                  ],
                ),
              )
            ],
          )
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: subTotal > 0
              ? () => orderController.processOrder(totalAmount)
              : () => Loaders.warningSnackBar(title: "Empty Cart", message: "Try adding one or more items in the cart."),
            child: Text('Checkout : ₹ ${TPricingCalculator.calculateTotalPrice(subTotal, "India")}')),
      ),
    );
  }
}


