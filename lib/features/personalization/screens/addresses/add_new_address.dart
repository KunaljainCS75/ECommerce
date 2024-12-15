import 'package:e_commercial_app/common/widgets/appbar/appbar.dart';
import 'package:e_commercial_app/features/personalization/controllers/address_controller.dart';
import 'package:e_commercial_app/utils/constants/sizes.dart';
import 'package:e_commercial_app/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Scaffold(
      appBar: const TAppBar(showBackArrow: true, title: Text('Add new Address')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              children: [
                TextFormField(
                    controller: controller.name,
                    validator: (value) => Validator.validateEmptyText('Name', value),
                    decoration: const InputDecoration(prefixIcon: Icon(Iconsax.user), labelText: 'Name')
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(
                    controller: controller.phoneNumber,
                    validator: (value) => Validator.validatePhoneNumber(value),
                    decoration: const InputDecoration(prefixIcon: Icon(Iconsax.mobile), labelText: 'Phone')),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                            controller: controller.street,
                            validator: (value) => Validator.validateEmptyText('Street', value),
                            decoration: const InputDecoration(prefixIcon: Icon(Iconsax.building_31), labelText: 'Street'))),
                    const SizedBox(width: TSizes.spaceBtwInputFields),
                    Expanded(child:
                    TextFormField(
                        controller: controller.postalCode,
                        validator: (value) => Validator.validateEmptyText('Postal Code', value),
                        decoration: const InputDecoration(prefixIcon: Icon(Iconsax.code), labelText: 'Postal Code'))),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                            controller: controller.city,
                            validator: (value) => Validator.validateEmptyText('City', value),
                            decoration: const InputDecoration(prefixIcon: Icon(Iconsax.building), labelText: 'City'))),
                    const SizedBox(width: TSizes.spaceBtwInputFields),
                    Expanded(
                        child: TextFormField(
                            controller: controller.state,
                            validator: (value) => Validator.validateEmptyText('State', value),
                            decoration: const InputDecoration(prefixIcon: Icon(Iconsax.activity), labelText: 'State'))),
                  ],
                ),

                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(
                    controller: controller.country,
                    validator: (value) => Validator.validateEmptyText('Country', value),
                    decoration: const InputDecoration(prefixIcon: Icon(Iconsax.global), labelText: 'Country')),
                const SizedBox(height: TSizes.defaultSpace),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () => controller.addNewAddress(),
                        child: const Text('Save')))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
