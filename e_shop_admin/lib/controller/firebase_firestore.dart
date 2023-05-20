import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop_admin/constants/constants.dart';
import 'package:e_shop_admin/models/category_model.dart';
import 'package:e_shop_admin/models/product_model.dart';

class FirebaseFirestoreMethode {
  static FirebaseFirestoreMethode instance = FirebaseFirestoreMethode();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getOrders() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("categories").get();

      List<CategoryModel> categoriesList = querySnapshot.docs
          .map((e) => CategoryModel.fromJson(e.data()))
          .toList();

      return categoriesList;
    } catch (e) {
      errorMessage(e.toString());
      return [];
    }
  }

  Future<int> getUserCount() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('users').get();
      return snapshot.size;
    } catch (e) {
      errorMessage(e.toString());
      return 0;
    }
  }

  Future<int> getCategoryCount() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("categories").get();

      return querySnapshot.size;
    } catch (e) {
      errorMessage(e.toString());
      return 0;
    }
  }

  Future<int> getproductCount() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collectionGroup("products").get();

      return querySnapshot.size;
    } catch (e) {
      errorMessage(e.toString());
      return 0;
    }
  }

  Future<int> getorderCount() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("orders").get();

      return querySnapshot.size;
    } catch (e) {
      errorMessage(e.toString());
      return 0;
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("categories").get();

      List<CategoryModel> categoriesList = querySnapshot.docs
          .map((e) => CategoryModel.fromJson(e.data()))
          .toList();

      return categoriesList;
    } catch (e) {
      errorMessage(e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getProducts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collectionGroup("products").get();

      List<ProductModel> productModelList = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();

      return productModelList;
    } catch (e) {
      errorMessage(e.toString());
      return [];
    }
  }
}
