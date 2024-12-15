class CartItemModel {
  String productId;
  String title;
  double price;
  String? image;
  int quantity;
  String variationId;
  String? brandName;
  Map<String, String>? selectedVariation;
  
  /// Constructor
  CartItemModel({
   required this.productId,
   required this.quantity, 
   this.variationId = '',
   this.price = 0.0,
   this.title = '',
   this.brandName,
   this.selectedVariation,
   this.image 
  });
  
  static CartItemModel empty() => CartItemModel(productId: '', quantity: 0);

  Map<String, dynamic> toJson() {
    return {
      'productId' : productId,
      'title' : title,
      'image' : image,
      'price' : price,
      'quantity' : quantity,
      'variationId' : variationId,
      'brandName' : brandName,
      'selectedVariation' : selectedVariation,
    };
  }

  /// Create a Cart Item from JSON Map
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'],
      title: json['title'],
      price: json['price']?.toDouble(),
      image: json['image'],
      quantity: json['quantity'],
      variationId: json['variationId'],
      brandName: json['brandName'],
      selectedVariation: json['selectedVariation'] != null ? Map<String, String>.from(json['selectedVariation']) :  null,
    );
  }
}