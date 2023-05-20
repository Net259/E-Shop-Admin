import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    required this.image,
    this.id,
    this.categoryId, // Add categoryId field
    required this.name,
    required this.price,
    required this.prevprice,
    required this.description,
    required this.isFavourite,
    this.qty,
  });

  String image;
  String? id;
  String? categoryId; // Add categoryId field
  bool isFavourite;
  String name;
  double price;
  String prevprice;
  String description;

  int? qty;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        categoryId: json["categoryId"], // Parse categoryId field
        name: json["name"],
        description: json["description"],
        image: json["image"],
        isFavourite: false,
        qty: json["qty"],
        price: double.parse(json["price"].toString()),
        prevprice: json["prevprice"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "categoryId": categoryId, // Include categoryId field
        "name": name,
        "image": image,
        "description": description,
        "isFavourite": isFavourite,
        "price": price,
        "prevprice": prevprice,
        "qty": qty,
      };

  ProductModel copyWith({
    int? qty,
  }) =>
      ProductModel(
        id: id,
        categoryId: categoryId, // Include categoryId field
        name: name,
        description: description,
        image: image,
        isFavourite: isFavourite,
        qty: qty ?? this.qty,
        price: price,
        prevprice: prevprice,
      );
}
