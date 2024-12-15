

import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel{
  String id;
  String name;
  String image;
  String parentID;
  bool isFeatured;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isFeatured,
    this.parentID = ""
  });

  /// Empty Helper Function
  static CategoryModel empty() => CategoryModel(id: '', name: '', image: '', isFeatured: true);

  /// Model to JSON Structure (Firebase)
  Map <String, dynamic> toJson(){
    return {
      "Name" : name,
      "Image" : image,
      "ParentId" : parentID,
      "IsFeatured" : isFeatured
    };
  }

  /// Map JSON Oriented document snapshot from Firebase to UserModel
  factory CategoryModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    if (document.data() != null) {
      final data = document.data()!;

      // Map JSON record to Model
      return CategoryModel(
          id: document.id,
          name: data['Name'] ?? '',
          image: data['Image'] ?? '',
          parentID: data['ParentId'] ?? '',
          isFeatured: data['IsFeatured'] ?? false
      );
    } else {
      return CategoryModel.empty();
    }
  }
}