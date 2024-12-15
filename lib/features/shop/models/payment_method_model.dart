class PaymentMethodModel {
  String image, name;

  PaymentMethodModel({
    required this.name,
    required this.image
  });

  static PaymentMethodModel empty() => PaymentMethodModel(name: '', image: '');
}