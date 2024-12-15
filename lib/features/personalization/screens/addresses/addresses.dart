import 'dart:ffi';

import 'package:e_commercial_app/common/widgets/appbar/appbar.dart';
import 'package:e_commercial_app/features/personalization/controllers/address_controller.dart';
import 'package:e_commercial_app/features/personalization/screens/addresses/widgets/single_address.dart';
import 'package:e_commercial_app/utils/constants/colors.dart';
import 'package:e_commercial_app/utils/constants/sizes.dart';
import 'package:e_commercial_app/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'add_new_address.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () => Get.to(() => const AddNewAddressScreen()),
        backgroundColor: TColors.primary,
        child: const Icon(Iconsax.add, color: TColors.white),
      ),
      appBar: TAppBar(showBackArrow: true, title: Text('Addresses', style: Theme.of(context).textTheme.headlineSmall,),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: FutureBuilder(
            // key to trigger refresh
            key: Key(controller.refreshData.value.toString()),
            future: controller.getAllUserAddresses(),
            builder: (context, snapshot) {

              /// Handle loader, no record and error messages
              final response = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
              if (response != null) return response;

              final addresses = snapshot.data!;
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: addresses.length,
                  itemBuilder:
                      (_, index) =>
                          SingleAddress(
                          address: addresses[index],
                          onTap: () => controller.selectAddress(addresses[index]),
                     )
              );
              }
          ),
        ),
      ),
    );
  }
}
