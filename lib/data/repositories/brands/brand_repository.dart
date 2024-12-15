import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commercial_app/features/shop/models/brand_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';


class BrandRepository extends GetxController{
  static BrandRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;

  /// Get all Categories
  Future<List<BrandModel>> getAllBrands() async {
    try {
      // Fetch Brands from FireBase
      final snapshot = await _db.collection("Brands").get();
      final result = snapshot.docs.map((e) => BrandModel.fromSnapshot(e)).toList();
      return result;

    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get Brands based on CategoryId
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try{
      // Query to get all documents where categoryId matches the provided categoryId
      QuerySnapshot brandCategoryQuery = await _db.collection("BrandCategory").where("categoryId", isEqualTo: categoryId).get();

      // Extract brands from documents
      List<String> brandIds = brandCategoryQuery.docs.map((doc) => doc['brandId'] as String).toList();

      // Query to get all documents where the brandId is in the list of brandIds list
      // FieldPath.documentId to query documents in collection
      final brandsQuery = await _db.collection('Brands').where(FieldPath.documentId, whereIn: brandIds).limit(2).get();

      // Extract brand names and other relevant data from documents
      List<BrandModel> brands = brandsQuery.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();

      return brands;

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, while watching fetching brands';
    }
  }

}