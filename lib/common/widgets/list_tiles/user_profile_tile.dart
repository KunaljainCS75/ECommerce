import 'package:e_commercial_app/features/personalization/controllers/user_controller.dart';
import 'package:e_commercial_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/constants/image_strings.dart';
import '../images/circular_images.dart';
import '../loaders/shimmer_loader.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = UserController.instance;
    return ListTile(
      leading: Obx((){
        final networkImage = controller.user.value.profilePicture;
        final image = networkImage.isNotEmpty? networkImage : TImages.user;
        return controller.imageUploading.value?
        const ShimmerLoader(height: 30, width: 30, radius: 80)
            : CircularImage(image: image, width: 55, height: 55, isNetworkImage: networkImage.isNotEmpty, fit: BoxFit.cover, padding: 0);
      }),
      title: Text(controller.user.value.fullName, style: !dark? Theme.of(context).textTheme.headlineSmall!.apply(color: Colors.white) : Theme.of(context).textTheme.headlineSmall!.apply(fontSizeFactor: .75, fontWeightDelta: 3)),
      subtitle: Text(controller.user.value.email, style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white)),
      trailing: IconButton(onPressed: onPressed, icon: const Icon(Iconsax.edit, color: Colors.white)),
    );
  }
}