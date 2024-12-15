import 'package:e_commercial_app/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:e_commercial_app/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:e_commercial_app/common/widgets/texts/section_heading.dart';
import 'package:e_commercial_app/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commercial_app/features/admin/screens/add_products.dart';
import 'package:e_commercial_app/features/personalization/screens/addresses/addresses.dart';
import 'package:e_commercial_app/features/shop/screens/cart/cart.dart';
import 'package:e_commercial_app/features/shop/screens/orders/order_screen.dart';
import 'package:e_commercial_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/list_tiles/user_profile_tile.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../profile/profile.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header -->
            PrimaryHeaderContainer(
                child: Column(children: [
                /// AppBar -->
                TAppBar(
                  title: Text('Account Info', style: dark? Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.white) : Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.white, fontSizeFactor: .87, fontWeightDelta: 2)),
                ),
                const SizedBox(height: TSizes.spaceBtwSections / 3),

                /// User Profile Card:
                UserProfileTile(onPressed: () => Get.to(() => const ProfileScreen())),
                const SizedBox(height: TSizes.spaceBtwSections)
              ],
            )),

            /// List of Setting options (BODY)
            Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                /// -- Account Settings
                const SizedBox(height: TSizes.spaceBtwItems),

                // const SectionHeading(title: 'Admin Access', showActionButton: false),
                // const SizedBox(height: TSizes.spaceBtwItems),
                // SettingsMenuTile(icon: Icons.add_circle_outlined, title: 'Add Product', subtitle: 'Only Admins has permissions', onTap: () => Get.to(() => const AddProducts())),
                // const SizedBox(height: TSizes.spaceBtwItems),

                const SectionHeading(title: 'Account Settings', showActionButton: false),
                const SizedBox(height: TSizes.spaceBtwItems),

                SettingsMenuTile(icon: Iconsax.safe_home, title: 'My Addresses', subtitle: 'Set Shopping Delivery Status', onTap: () => Get.to(() => const UserAddressScreen())),
                SettingsMenuTile(icon: Iconsax.shopping_cart, title: 'My Cart', subtitle: 'Add or Remove products to purchase', onTap: () => Get.to(() => const CartScreen())),
                SettingsMenuTile(icon: Iconsax.bag_tick, title: 'My Orders', subtitle: 'In-Progress and Completed Orders', onTap: () => Get.to(() => const OrderScreen())),
                SettingsMenuTile(icon: Iconsax.bank, title: 'Bank Account', subtitle: 'Withdraw balance to registered bank account', onTap: (){},),
                SettingsMenuTile(icon: Iconsax.discount_shape, title: 'My Coupons', subtitle: 'List of all discounted coupons', onTap: (){},),
                SettingsMenuTile(icon: Iconsax.notification, title: 'Notifications', subtitle: 'Set any kind of notification message', onTap: (){},),
                SettingsMenuTile(icon: Iconsax.security_card, title: 'Account Privacy', subtitle: 'Manage Data usage and connected accounts', onTap: (){},),

                /// -- App Settings
                const SizedBox(height: TSizes.spaceBtwSections),
                const SectionHeading(title: 'App Settings', showActionButton: false),
                const SizedBox(height: TSizes.spaceBtwItems),
                SettingsMenuTile(icon: Iconsax.document_upload, title: 'Load Data', subtitle: 'Upload Data to your Cloud FireBase', onTap: (){}),
                SettingsMenuTile(icon: Iconsax.location, title: 'Geolocation', subtitle: 'Set recommendation based on location', trailing: Switch(value: true, onChanged: (value) {})),
                SettingsMenuTile(icon: Iconsax.security_user, title: 'Safe Mode', subtitle: 'Search result in safe for all ages', trailing: Switch(value: false, onChanged: (value) {})),
                SettingsMenuTile(icon: Iconsax.image, title: 'HD Image Quality', subtitle: 'Set product image resolution', trailing: Switch(value: false, onChanged: (value) {})),

                const SizedBox(height: TSizes.spaceBtwSections),
                SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () => AuthenticationRepository().logout(), child: const Text('Logout'))),
                const SizedBox(height: TSizes.spaceBtwSections * 2.5),
              ],
            ),)
          ],
        ),
      ),
    );
  }
}


