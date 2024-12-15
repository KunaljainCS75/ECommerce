import 'package:e_commercial_app/common/widgets/appbar/appbar.dart';
import 'package:e_commercial_app/common/widgets/images/circular_images.dart';
import 'package:e_commercial_app/common/widgets/loaders/shimmer_loader.dart';
import 'package:e_commercial_app/common/widgets/texts/section_heading.dart';
import 'package:e_commercial_app/features/personalization/screens/profile/widget/change_name.dart';
import 'package:e_commercial_app/features/personalization/screens/profile/widget/profile_menu.dart';
import 'package:e_commercial_app/utils/constants/image_strings.dart';
import 'package:e_commercial_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../controllers/user_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const TAppBar(
        title: Text('Profile'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx((){
                      final networkImage = controller.user.value.profilePicture;
                      final image = networkImage.isNotEmpty? networkImage : TImages.user;
                      return controller.imageUploading.value?
                        const ShimmerLoader(height: 80, width: 80, radius: 80)
                            : CircularImage(image: image, width: 80, height: 80, isNetworkImage: networkImage.isNotEmpty, fit: BoxFit.cover);
                    }),
                    TextButton(onPressed: () => controller.uploadUserProfilePicture(), child: const Text('Change Profile Picture')),
                  ],
                ),
              ),
              /// Details
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Heading Profile Info
              const SectionHeading(title: 'Profile Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Information
              ProfileMenu(title: 'Name', value: controller.user.value.fullName, onPressed: () => Get.to(() => const ChangeName())),
              ProfileMenu(title: 'Username', value: controller.user.value.username, showIcon: false, onPressed: (){}),

              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Heading Personal Info
              const SectionHeading(title: 'Personal Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Information
              ProfileMenu(title: 'User-ID', value: controller.user.value.id, onPressed: (){}, icon: Iconsax.copy,),
              ProfileMenu(title: 'Email', value: controller.user.value.email, onPressed: (){}, showIcon: false),
              ProfileMenu(title: 'Mobile', value: controller.user.value.phoneNumber, onPressed: (){}),
              ProfileMenu(title: 'Gender', value: 'Male', onPressed: (){}),
              ProfileMenu(title: 'Date of Birth', value: '16 Jul 2004', onPressed: (){}),

              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: const Text('Close Account', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),

      ),
    );
  }
}


