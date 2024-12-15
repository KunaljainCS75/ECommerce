import 'package:e_commercial_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_commercial_app/common/widgets/texts/product_price_text.dart';
import 'package:e_commercial_app/common/widgets/texts/product_title_text.dart';
import 'package:e_commercial_app/common/widgets/texts/section_heading.dart';
import 'package:e_commercial_app/features/shop/controllers/product/variation_controller.dart';
import 'package:e_commercial_app/features/shop/models/product_model.dart';
import 'package:e_commercial_app/utils/constants/colors.dart';
import 'package:e_commercial_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/chips/choice_chip.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({
    super.key,
    required this.product
  });
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(VariationController());
    return Obx(
      () => Column(
        children: [
          /// Selected Attribute & pricing
            if (controller.selectedVariation.value.id.isNotEmpty)
              RoundedContainer(
            padding: const EdgeInsets.all(TSizes.md),
            showBorder: true,
            backgroundColor: dark? TColors.darkerGrey : Colors.transparent,
            borderColor: dark? TColors.white : TColors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionHeading(title: 'Variation Price:', showActionButton: false, textColor: dark? TColors.white : TColors.black),
                const SizedBox(height: TSizes.spaceBtwItems / 2),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const ProductTitleText(title: 'Price : ', smallSize: true),

                        /// Actual Price
                        if (controller.selectedVariation.value.salePrice > 0)
                          Text(
                          'Rs. ${controller.selectedVariation.value.price}',
                          style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough),
                          ),
                        if (controller.selectedVariation.value.salePrice > 0) const SizedBox(width: TSizes.spaceBtwItems),

                        /// Sale Price
                        PriceText(price: controller.getVariationPrice())
                      ],
                    ),
                    Row(
                      children: [
                        const ProductTitleText(title: 'Variation Stock Status:  ', smallSize: true),
                        Text(controller.variationStockStatus.value, style: Theme.of(context).textTheme.titleMedium)

                      ],
                    )
                  ],
                ),


              ],
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          /// Attributes
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!.map((attribute) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionHeading(title: attribute.name ?? '', showActionButton: false),
                const SizedBox(height: TSizes.spaceBtwItems / 4),
                Obx(
                () => Wrap(
                    spacing: 8,
                    children: attribute.values!.map((attributeValue) {
                      final isSelected = controller.selectedAttributes[attribute.name] == attributeValue;
                      final available =  controller.getAttributesAvailabilityVariation(product.productVariations!, attribute.name!)
                          .contains(attributeValue);
                      return ChoiceChipSet(
                      selected: isSelected, text: attributeValue, onSelected: available? (selected) {
                        if (selected && available){
                          controller.onAttributeSelected(product, attribute.name ?? '', attributeValue);
                        }
                      }: null);
                      }).toList()
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwItems / 2)
              ],
            )).toList(),
          ),

        ],
      ),
    );
  }
}

