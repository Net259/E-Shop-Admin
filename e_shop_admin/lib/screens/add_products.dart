import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop_admin/constants/colors.dart';
import 'package:e_shop_admin/constants/constants.dart';
import 'package:e_shop_admin/controller/firebase_storage.dart';
import 'package:e_shop_admin/models/category_model.dart';
import 'package:e_shop_admin/models/product_model.dart';
import 'package:e_shop_admin/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  var imageUrl = '';
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference productRef =
      FirebaseFirestore.instance.collection('products');
  TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _prevPriceController = TextEditingController();
  List<CategoryModel> categories = [];
  CategoryModel? selectedCategory;
  String? selectedCategoryName;

  File? image;
  void takePicture() async {
    XFile? value = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 40);
    if (value != null) {
      setState(() {
        image = File(value.path);
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _prevPriceController.dispose();
    super.dispose();
  }

  void fetchCategories() {
    _firebaseFirestore
        .collection("categories")
        .get()
        .then((QuerySnapshot querySnapshot) {
      List<CategoryModel> categoriesList =
          querySnapshot.docs.map((DocumentSnapshot documentSnapshot) {
        return CategoryModel.fromJson(
            documentSnapshot.data() as Map<String, dynamic>);
      }).toList();

      setState(() {
        categories = categoriesList;
        selectedCategory = categoriesList.isNotEmpty ? categoriesList[0] : null;
      });
    }).catchError((error) {
      errorMessage(error.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.col,
        title: const CustomText(
            text: 'Add Product', color: Colors.white, size: 16),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  image == null
                      ? CupertinoButton(
                          onPressed: () {
                            takePicture();
                          },
                          child: Container(
                            width: 300,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Palette.col.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 10),
                                  blurRadius: 10,
                                  color: Color.fromARGB(70, 0, 0, 0),
                                )
                              ],
                            ),
                            child: const Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        )
                      : CupertinoButton(
                          onPressed: () {
                            takePicture();
                          },
                          child: Container(
                            width: 300,
                            height: 200,
                            decoration: BoxDecoration(
                              border: Border.all(color: Palette.col, width: 2),
                              image: DecorationImage(
                                image: FileImage(image!),
                                fit: BoxFit.cover,
                              ),
                              color: Palette.col.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 10),
                                  blurRadius: 10,
                                  color: Color.fromARGB(70, 0, 0, 0),
                                )
                              ],
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(
                          color: Palette.col,
                          fontFamily: 'merienda',
                          fontSize: 15),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Palette.col,
                          width: 2,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(
                          color: Palette.col,
                          fontFamily: 'merienda',
                          fontSize: 15),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Palette.col,
                          width: 2,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _priceController,
                    decoration: const InputDecoration(
                      labelText: 'Price',
                      labelStyle: TextStyle(
                          color: Palette.col,
                          fontFamily: 'merienda',
                          fontSize: 15),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Palette.col,
                          width: 2,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a price';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid price';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _prevPriceController,
                    decoration: const InputDecoration(
                      labelText: 'Previous Price',
                      labelStyle: TextStyle(
                          color: Palette.col,
                          fontFamily: 'merienda',
                          fontSize: 15),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Palette.col,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField<CategoryModel>(
                      value: selectedCategory,
                      items: categories.map((CategoryModel category) {
                        return DropdownMenuItem<CategoryModel>(
                          value: category,
                          child: CustomText(
                            text: category.name,
                            color: Palette.col,
                            size: 15,
                          ),
                        );
                      }).toList(),
                      onChanged: (CategoryModel? newValue) {
                        setState(() {
                          selectedCategory = newValue;
                          selectedCategoryName = newValue?.id;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Category',
                        labelStyle: TextStyle(
                            color: Palette.col,
                            fontFamily: 'merienda',
                            fontSize: 15),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Palette.col,
                            width: 2,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a category';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 300,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Palette.col,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 10,
                          color: Color.fromARGB(70, 0, 0, 0),
                        )
                      ],
                    ),
                    child: CupertinoButton(
                      onPressed: _submitForm,
                      child: const CustomText(
                        text: 'Add Product',
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        String name = _nameController.text;
        String description = _descriptionController.text;
        double price = double.parse(_priceController.text);
        String prevPrice = _prevPriceController.text;
        String cid = selectedCategory!.id.toString();
        FirebaseStorageHelper firebaseStorageHelper = FirebaseStorageHelper();
        String imageUrl =
            await firebaseStorageHelper.uploadProductImage(image!);

        ProductModel newProduct = ProductModel(
          name: name,
          description: description,
          price: price,
          prevprice: prevPrice,
          image: imageUrl,
          isFavourite: false,
          categoryId: cid,
        );
        DocumentReference newProductRef = productRef.doc();
        String productId = newProductRef.id;

        newProduct.id = productId;
        newProduct.categoryId = cid; // Set the categoryId field

        FirebaseFirestore.instance
            .collection('categories')
            .doc(selectedCategoryName!)
            .collection('products')
            .add(newProduct.toJson())
            .then((value) {})
            .catchError((error) {});

        successMessage("Product added successfully");
        // ignore: use_build_context_synchronously
        Navigator.of(context, rootNavigator: true).pop();
      } catch (e) {
        errorMessage(e.toString());
        Navigator.of(context, rootNavigator: true).pop();
      }
    }
  }
}
