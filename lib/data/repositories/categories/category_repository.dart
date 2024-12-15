import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commercial_app/features/shop/models/category_model.dart';
import 'package:e_commercial_app/utils/firebase_storage_service.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;

  /// Get all Categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection("Categories").get();
      final list = snapshot.docs.map((document) =>
          CategoryModel.fromSnapshot(document)).toList();
      return list;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get SubCategories
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final snapshot = await _db.collection('Categories').where(
          'ParentId', isEqualTo: categoryId).get();
      final list = snapshot.docs.map((document) =>
          CategoryModel.fromSnapshot(document)).toList();
      return list;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Upload Categories to Cloud Firestore
  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try {
      // Upload all categories along with Images
      final storage = Get.put(FirebaseStorageService());

      // Loop through each category
      for (var category in categories) {
        // Get ImageData link from local assets
        final file = await storage.getImageDataFromAssets(category.image);

        // Upload image and get its URL
        final url = await storage.uploadImageData(
            'Categories', file, category.name);

        // Assign URL to Category.image attribute
        category.image = url;

        // Store Category in FireStore
        await _db.collection("Categories").doc(category.id).set(
            category.toJson());
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}