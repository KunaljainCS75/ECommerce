import 'package:e_commercial_app/features/shop/controllers/product/cart_controller.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/pricing_calculator.dart';

class BillingAmountSection extends StatelessWidget {
  const BillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    final subTotal = controller.totalCartPrice.value;

    return Column(
      children: [
        /// SubTotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Subtotal: ', style: Theme.of(context).textTheme.bodyMedium),
            Text('₹ ${subTotal.toStringAsFixed(2)}', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        /// Shipping Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shipping Fee: ', style: Theme.of(context).textTheme.bodyMedium),
            Text('+ ₹ ${TPricingCalculator.calculateShippingCost(subTotal, 'India')}', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        /// Tax Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tax Fee: ', style: Theme.of(context).textTheme.bodyMedium),
            Text('+ ₹ ${TPricingCalculator.calculateTax( subTotal, 'India')}', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        /// Order Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order Total: ', style: Theme.of(context).textTheme.bodyMedium),
            Text('= ₹ ${TPricingCalculator.calculateTotalPrice(subTotal, "India").toStringAsFixed(2)}', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
      ],
    );
  }
}
