import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop_admin/models/product_model.dart';

class OrderModel {
  OrderModel({
    required this.totalPrice,
    required this.orderId,
    required this.payment,
    required this.products,
    required this.orderDate,
    required this.status,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
  });

  String payment;
  String status;
  String name;
  String phone;
  String email;
  String address;
  final DateTime orderDate;
  List<ProductModel> products;
  double totalPrice;
  String orderId;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> productMap = json["products"];
    Timestamp timestamp = json["orderDate"];
    DateTime orderDate = timestamp.toDate();
    return OrderModel(
      orderId: json["orderId"],
      products: productMap.map((e) => ProductModel.fromJson(e)).toList(),
      totalPrice: json["totalPrice"],
      status: json["status"],
      orderDate: orderDate,
      payment: json["payment"],
      name: json["name"],
      phone: json["phone"],
      email: json["email"],
      address: json["address"],
    );
  }
}
