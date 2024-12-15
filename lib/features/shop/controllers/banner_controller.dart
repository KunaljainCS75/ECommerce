import 'package:e_commercial_app/data/repositories/banners/banner_repository.dart';
import 'package:get/get.dart';

import '../../../utils/popups/loaders.dart';
import '../models/banner_model.dart';

class BannerController extends GetxController {

  /// Variables
  final isLoading = false.obs;
  final carouselCurrentIndex = 0.obs; // observed and updated by GetX observer
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  /// Update Page Navigational dots
  void updatePageIndicator(index){
    carouselCurrentIndex.value = index;
  }


  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  /// Fetch Banners
  Future<void> fetchBanners() async {
    try{
      // Show Loader while loading categories
      isLoading.value = true;

      // Fetch Banners
      final bannerRepository = Get.put(BannerRepository());
      final banners = await bannerRepository.fetchBanners();

      // Assign Banners
      this.banners.assignAll(banners);

    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      // Remove Loader
      isLoading.value = false;
    }
  }
}