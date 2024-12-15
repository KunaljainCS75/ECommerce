import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commercial_app/features/shop/models/product_attributes_model.dart';
import 'package:e_commercial_app/features/shop/models/product_variations_model.dart';
import 'brand_model.dart';

class ProductModel {
  String id;
  double price;
  String title;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  String productType;
  int stock;
  BrandModel? brand;
  String? description;
  String? categoryId;
  List<String>? images;
  String? sku;
  DateTime? date;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  ProductModel({
    required this.id,
    required this.title,
    this.isFeatured,
    required this.price,
    required this.thumbnail,
    required this.productType,
    this.salePrice = 0.0,
    required this.stock,
    this.categoryId,
    this.brand,
    this.description,
    this.sku,
    this.date,
    this.images,
    this.productAttributes,
    this.productVariations
  });

  /// Create Empty func for clean code
  static ProductModel empty() => ProductModel(id: '', title: '',stock: 0, price: 0, thumbnail: 'https://www.pngall.com/wp-content/uploads/11/Apple-Logo-PNG-HD-Image.png', productType: '');

  /// JSON Format
  toJson(){
    return{
      'Title' : title,
      'Id' : id,
      'Thumbnail' : thumbnail,
      'IsFeatured' : isFeatured,
      'Price' : price,
      'SalePrice' : salePrice,
      'ProductType' : productType,
      'Stock' : stock,
      'CategoryId' : categoryId,
      'Brand' : brand!.toJson(),
      'Description' : description,
      'SKU' : sku,
      'Images' : images ?? [],
      'ProductAttributes' : productAttributes != null ? productAttributes!.map((e) => e.toJson()).toList() : [],
      'ProductVariations' : productVariations != null ? productVariations!.map((e) => e.toJson()).toList() : []
    };
  }

  /// Map JSON Oriented document snapshot from FireBase to Model
  factory ProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    if (data.isEmpty) return ProductModel.empty();
    return ProductModel(
      id: document.id,
      price: double.parse((data['Price'] ?? 0.0).toString()),
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      title: data['Title'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
      thumbnail: data['Thumbnail'] ?? '',
      productType: data['ProductType'] ?? 'ProductType.single',
      stock: data['Stock'] ?? 0,
      brand: BrandModel.fromJson(data['Brand']),
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      sku: data['SKU'] ?? '',
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes: (data['ProductAttributes'] as List<dynamic>).map((e) => ProductAttributeModel.fromJson(e)).toList(),
      productVariations: (data['ProductVariations'] as List<dynamic>).map((e) => ProductVariationModel.fromJson(e)).toList(),
    );
  }

  /// Map JSON Oriented document snapshot from FireBase to Model
  factory ProductModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map <String, dynamic>;
    return ProductModel(
      id: document.id,
      price: double.parse((data['Price'] ?? 0.0).toString()),
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      title: data['Title'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
      thumbnail: data['Thumbnail'] ?? '',
      productType: data['ProductType'] ?? 'ProductType.single',
      stock: data['Stock'] ?? 0,
      brand: BrandModel.fromJson(data['Brand']),
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      // sku: data['SKU'] ?? '',
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes: (data['ProductAttributes'] as List<dynamic>).map((e) => ProductAttributeModel.fromJson(e)).toList(),
      productVariations: (data['ProductVariations'] as List<dynamic>).map((e) => ProductVariationModel.fromJson(e)).toList(),
    );
  }
}
