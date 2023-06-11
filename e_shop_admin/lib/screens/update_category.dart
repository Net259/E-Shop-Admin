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

class UpdateCategory extends StatefulWidget {
  final CategoryModel categoryModel;
  const UpdateCategory({super.key, required this.categoryModel});

  @override
  State<UpdateCategory> createState() => _UpdateCategoryState();
}

class _UpdateCategoryState extends State<UpdateCategory> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference categoriesRef =
      FirebaseFirestore.instance.collection('categories');

  @override
  void initState() {
    super.initState();
    nameController.text = widget.categoryModel.name;
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

  Future<void> updateCategory() async {
    String name = nameController.text;
    String? categoryId = widget.categoryModel.id;
    String imageUrl = widget.categoryModel.image;

    if (image != null) {
      FirebaseStorageHelper firebaseStorageHelper = FirebaseStorageHelper();
      imageUrl = await firebaseStorageHelper.uploadCategoryImage(image!);
    }

    CategoryModel updatedCategory = CategoryModel(
      id: categoryId,
      name: name,
      image: imageUrl,
    );

    DocumentReference categoryRef = categoriesRef.doc(categoryId);
    await categoryRef.update(updatedCategory.toJson());

    successMessage("Category updated successfully");
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
            text: 'Update Category', color: Colors.white, size: 16),
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
                        hintText: widget.categoryModel.name,
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
                      onPressed: updateCategory,
                      child: const CustomText(
                        text: 'Update Category',
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
