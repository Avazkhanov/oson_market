class ProductModel {
  final String docId;
  final String userId;
  final String productName;
  final String productDescription;
  final double price;
  final String imageUrl;
  final String categoryId;
  final String monetaryUnit;

  ProductModel({
    required this.price,
    required this.imageUrl,
    required this.productName,
    required this.docId,
    required this.productDescription,
    required this.categoryId,
    required this.userId,
    required this.monetaryUnit,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      docId: json["doc_id"] as String? ?? "",
      imageUrl: json["image_url"] as String? ?? "",
      categoryId: json["category_id"] as String? ?? "",
      productName: json["product_name"] as String? ?? "",
      productDescription: json["product_description"] as String? ?? "",
      userId: json["user_id"] as String ?? "",
      price: json["price"] as double? ?? 0.0,
      monetaryUnit: json["monetary_unit"] as String ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "doc_id": "",
      "image_url": imageUrl,
      "product_name": productName,
      "product_description": productDescription,
      "price": price,
      "category_id": categoryId,
      "user_id": userId,
      "monetary_unit": monetaryUnit
    };
  }

  Map<String, dynamic> toJsonForUpdate() {
    return {
      "image_url": imageUrl,
      "product_name": productName,
      "product_description": productDescription,
      "price": price,
      "category_id": categoryId,
      "monetary_unit": monetaryUnit
    };
  }
  ProductModel copyWith({
    String? docId,
    String? userId,
    String? productName,
    String? productDescription,
    double? price,
    String? imageUrl,
    String? categoryId,
    String? monetaryUnit,
  }) {
    return ProductModel(
      docId: docId?? this.docId,
      userId: userId?? this.userId,
      productName: productName?? this.productName,
      productDescription: productDescription?? this.productDescription,
      price: price?? this.price,
      imageUrl: imageUrl?? this.imageUrl,
      categoryId: categoryId?? this.categoryId,
      monetaryUnit: monetaryUnit?? this.monetaryUnit,
    );
  }

}

extension CanInsert on ProductModel {
  bool canInsertProduct() {
    return productName.isNotEmpty &&
        productDescription.isNotEmpty &&
        price > 0 &&
        monetaryUnit.isNotEmpty &&
        imageUrl.isNotEmpty &&
        categoryId.isNotEmpty &&
        userId.isNotEmpty;
  }
}
