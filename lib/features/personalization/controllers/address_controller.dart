import 'package:e_commercial_app/common/widgets/texts/section_heading.dart';
import 'package:e_commercial_app/data/repositories/address/address_repository.dart';
import 'package:e_commercial_app/features/personalization/models/address/address_model.dart';
import 'package:e_commercial_app/features/personalization/screens/addresses/widgets/single_address.dart';
import 'package:e_commercial_app/utils/constants/sizes.dart';
import 'package:e_commercial_app/utils/helpers/cloud_helper_functions.dart';
import 'package:e_commercial_app/utils/helpers/network_manager.dart';
import 'package:e_commercial_app/utils/popups/full_screen_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/popups/loaders.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final addressRepository = Get.put(AddressRepository());
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  RxBool refreshData = true.obs;

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final city = TextEditingController();
  final postalCode = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  /// Fetch all user specific addresses
  Future<List<AddressModel>> getAllUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchAddresses();
      selectedAddress.value = addresses.firstWhere((element) => element.selectedAddress, orElse: () => AddressModel.empty());
      return addresses;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Address not found!', message: e.toString());
      return [];
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      // Clear the 'selected' field
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(selectedAddress.value.id, false);
      }

      // Assign selected Address
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      // Set the "selected" field to true for the newly selected address
      await addressRepository.updateSelectedField(
          selectedAddress.value.id, true);
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error in Selection', message: e.toString());
    }
  }

  // Add new Address
  Future addNewAddress() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog('Saving Address...', TImages.productsSaleIllustration);

      // Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected){
        FullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!addressFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Save Address data
      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        country: country.text.trim(),
        state: state.text.trim(),
        city: city.text.trim(),
        street: street.text.trim(),
        postalCode: postalCode.text.trim(),
        selectedAddress: true,
      );

      final id = await addressRepository.addAddress(address);

      // Update selected Address status
      address.id = id;
      await selectAddress(address);

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show Success Message
      Loaders.successSnackBar(title: "Successfully added new address", message: 'A new address has been added to your address list');

      // Refresh Address data
      refreshData.toggle();

      // Reset form fields
      resetFormFields();

      // Redirect
      Navigator.of(Get.context!).pop();

    } catch (e) {
      // Remove Loader
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: "Address can't be added, try again...", message: e.toString());
    }
  }

  /// Show Address ModalBottomSheet at CheckOut
  Future<dynamic> selectNewAddressPopup(BuildContext context){
    return showModalBottomSheet(
        context: context,
        builder: (_) => Container(
          padding: const EdgeInsets.all(TSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeading(title: "Select Address", showActionButton: false),
              FutureBuilder(
                future: getAllUserAddresses(),
                builder: (_, snapshot) {

                  /// Helper Functions
                  final response = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                  if (response != null) return response;

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => SingleAddress(
                      address: snapshot.data![index],
                      onTap: () async {
                        await selectAddress(snapshot.data![index]);
                        Get.back();
                      },
                    ),
                  );
                },
              )
            ],
          ),
        )
    );
  }

  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    country.clear();
    state.clear();
    city.clear();
    street.clear();
    postalCode.clear();
    addressFormKey.currentState!.reset();
  }
}