import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop_admin/constants/colors.dart';
import 'package:e_shop_admin/constants/constants.dart';
import 'package:e_shop_admin/controller/firebase_storage.dart';
import 'package:e_shop_admin/models/category_model.dart';
import 'package:e_shop_admin/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final _formkey = GlobalKey<FormState>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference categoriesRef =
      FirebaseFirestore.instance.collection('categories');
  TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();

    super.dispose();
  }

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

  Future<void> addCategory() async {
    String name = nameController.text;
    FirebaseStorageHelper firebaseStorageHelper = FirebaseStorageHelper();
    String imageUrl = await firebaseStorageHelper.uploadCategoryImage(image!);
    CategoryModel newCategory = CategoryModel(
      name: name,
      image: imageUrl,
    );

    DocumentReference newCategoryRef = categoriesRef.doc();
    String categoryId = newCategoryRef.id;

    newCategory.id = categoryId;

    newCategoryRef.set(newCategory.toJson());
    successMessage("Category added successfully");
    nameController.clear();

    // ignore: use_build_context_synchronously
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.col,
        title: const CustomText(
            text: 'Add Category', color: Colors.white, size: 16),
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  image == null
                      ? CircleAvatar(
                          radius: 80,
                          backgroundColor: Palette.col.withOpacity(0.5),
                          child: IconButton(
                            onPressed: () => takePicture(),
                            icon: const Icon(Icons.add_a_photo),
                            color: Colors.white,
                            iconSize: 30,
                          ),
                        )
                      : CupertinoButton(
                          onPressed: () => takePicture(),
                          child: CircleAvatar(
                            backgroundColor: Palette.col,
                            radius: 81,
                            child: CircleAvatar(
                              radius: 80,
                              backgroundColor: Palette.col.withOpacity(0.5),
                              backgroundImage: FileImage(image!),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Palette.col,
                            width: 2,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Palette.col,
                            width: 1,
                          ),
                        ),
                        hintText: 'Enter Category Name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter Category name';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
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
                      onPressed: addCategory,
                      child: const CustomText(
                        text: 'Add Category',
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
}
