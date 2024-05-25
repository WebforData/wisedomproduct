// ignore: file_names
class ProductDataModel {
  String? title;
  String? url;
  String? itemLocation;
  String? shippingOption;
  String? sellerName;
  String? numberOfProducts;
  String? returns;
  String? shipping;
  String? delivery;
  String? condition;
  String? price;
  bool hasLowestPrice;

  ProductDataModel({
    required this.title,
    required this.url,
    required this.itemLocation,
    required this.shippingOption,
    required this.sellerName,
    required this.numberOfProducts,
    required this.returns,
    required this.shipping,
    required this.delivery,
    required this.condition,
    required this.price,
    required this.hasLowestPrice
  });

  factory ProductDataModel.fromJson(Map<String, dynamic> json) {
    String title = removeTextBetweenBrackets(json['Title']);
    bool hasLowestPrice = title.toLowerCase().contains('lowest price');
    return ProductDataModel(
      title: title,
      url: json['Url'],
      itemLocation: json['Item Location'],
      shippingOption: json['Shipping Option'],
      sellerName: json['Seller Name'],
      numberOfProducts: json['Number of Products'],
      returns: json['Returns'],
      shipping: json['Shipping'],
      delivery: json['Delivery'],
      condition: json['Condition'],
      price: json['Price'],
      hasLowestPrice:hasLowestPrice,
    );
  }

 static String removeTextBetweenBrackets(String text) {
    RegExp regex = RegExp(r'\u3010.*?\u3011');
    return text.replaceAll(regex, '').trim();
  }

}