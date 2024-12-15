import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BannerModel{
  String imgUrl;
  final String targetScreen;
  final bool active;

  BannerModel({
  required this.targetScreen, required this.active, required this.imgUrl
  });

  Map <String, dynamic> toJson() {
    return {
      "ImageUrl" : imgUrl,
      "TargetScreen" : targetScreen,
      "Active" : active
    };
  }

  factory BannerModel.fromSnapshot(DocumentSnapshot snapshot){
    final data = snapshot.data() as Map<String, dynamic>;
    return BannerModel(
        imgUrl: data["ImageUrl"] ?? '',
        targetScreen: data['TargetScreen'] ?? '',
        active: data['Active'] ?? false,
    );
  }
}