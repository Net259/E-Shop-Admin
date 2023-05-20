import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop_admin/constants/colors.dart';
import 'package:e_shop_admin/constants/constants.dart';
import 'package:e_shop_admin/constants/route.dart';
import 'package:e_shop_admin/controller/firebase_firestore.dart';
import 'package:e_shop_admin/models/category_model.dart';
import 'package:e_shop_admin/models/product_model.dart';
import 'package:e_shop_admin/screens/add_category.dart';
import 'package:e_shop_admin/screens/add_products.dart';
import 'package:e_shop_admin/screens/detail_product.dart';
import 'package:e_shop_admin/screens/orders.dart';
import 'package:e_shop_admin/screens/update_category.dart';
import 'package:e_shop_admin/widgets/custom_text.dart';
import 'package:e_shop_admin/widgets/number_of_thing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModel> categoriesList = [];
  List<ProductModel> productModelList = [];

  bool isLoading = false;
  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    categoriesList = await FirebaseFirestoreMethode.instance.getCategories();
    productModelList = await FirebaseFirestoreMethode.instance.getProducts();

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void refreshCategoryList() async {
    setState(() {
      isLoading = true;
    });

    categoriesList = await FirebaseFirestoreMethode.instance.getCategories();
    productModelList = await FirebaseFirestoreMethode.instance.getProducts();

    setState(() {
      isLoading = false;
    });
  }

  String cid = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.col,
        title: const CustomText(
            text: "E-Shop Admin", color: Colors.white, size: 16),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 10, right: 10, left: 10, bottom: 20),
                    child: Row(
                      children: [
                        UserCount(),
                        SizedBox(
                          width: 10,
                        ),
                        CategoryCount(),
                        SizedBox(
                          width: 10,
                        ),
                        ProductCount(),
                        SizedBox(
                          width: 10,
                        ),
                        OrderCount(),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 12,
                ),
                const SizedBox(
                  height: 22,
                ),
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Palette.col,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        color: Color.fromARGB(70, 0, 0, 0),
                      )
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: CupertinoButton(
                    child: const CustomText(
                      text: "Add Category",
                      color: Colors.white,
                      size: 14,
                    ),
                    onPressed: () {
                      Routes.instance
                          .push(widget: const AddCategory(), context: context);
                    },
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Palette.col,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        color: Color.fromARGB(70, 0, 0, 0),
                      )
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: CupertinoButton(
                    child: const CustomText(
                      text: "Add Product",
                      color: Colors.white,
                      size: 14,
                    ),
                    onPressed: () {
                      Routes.instance
                          .push(widget: const AddProduct(), context: context);
                    },
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Palette.col,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        color: Color.fromARGB(70, 0, 0, 0),
                      )
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: CupertinoButton(
                    child: const CustomText(
                      text: "Orders",
                      color: Colors.white,
                      size: 14,
                    ),
                    onPressed: () {
                      Routes.instance
                          .push(widget: const Orders(), context: context);
                    },
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 18, bottom: 8),
            child: SizedBox(
              height: 22,
              width: double.infinity,
              child: CustomText(
                text: "Categories",
                color: Palette.col,
                size: 16,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categoriesList
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 4,
                                      color: Colors.grey,
                                      spreadRadius: 4)
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(
                                  e.image,
                                ),
                                backgroundColor: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              e.name,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'merienda',
                                  color: Palette.col),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const CustomText(
                                        text: 'Delete Category',
                                        color: Colors.red,
                                        size: 12,
                                      ),
                                      content: const CustomText(
                                        text:
                                            'Are you sure you want to delete Category?',
                                        color: Colors.black,
                                        size: 12,
                                      ),
                                      actions: [
                                        TextButton(
                                          child: const CustomText(
                                            text: 'No',
                                            color: Colors.black,
                                            size: 12,
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const CustomText(
                                            text: 'Yes',
                                            color: Colors.red,
                                            size: 12,
                                          ),
                                          onPressed: () {
                                            FirebaseFirestore.instance
                                                .collection('categories')
                                                .doc(e.id)
                                                .delete()
                                                .then((_) {
                                              // Delete associated product documents
                                              FirebaseFirestore.instance
                                                  .collection('categories')
                                                  .doc(e.id)
                                                  .collection('products')
                                                  .get()
                                                  .then((snapshot) {
                                                for (DocumentSnapshot doc
                                                    in snapshot.docs) {
                                                  doc.reference.delete();
                                                }
                                              }).then((_) {
                                                refreshCategoryList();
                                              }).catchError((error) {
                                                errorMessage(
                                                    'Failed to delete associated product documents: $error');
                                              });
                                            }).catchError((error) {
                                              errorMessage(
                                                  'Failed to delete category: $error');
                                            });
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                              ),
                              child: const CustomText(
                                  text: "Delete", color: Colors.red, size: 12),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Routes.instance.push(
                                    widget: UpdateCategory(categoryModel: e),
                                    context: context);
                                refreshCategoryList();
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                              ),
                              child: const CustomText(
                                  text: "Update",
                                  color: Colors.amber,
                                  size: 12),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          //////////////////////////////////////////////////////////////////////////////////////
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 18, bottom: 8),
            child: SizedBox(
              height: 18,
              width: double.infinity,
              child: CustomText(
                text: "All Products",
                color: Palette.col,
                size: 16,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: double.infinity,
            child: SingleChildScrollView(
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: productModelList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.70,
                ),
                itemBuilder: (context, index) {
                  ProductModel singleProduct = productModelList[index];
                  return GestureDetector(
                    onTap: () {
                      Routes.instance.push(
                        widget: Details(singleProduct: singleProduct),
                        context: context,
                      );
                    },
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: 200,
                                  height: 200,
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                      image: NetworkImage(singleProduct.image),
                                      fit: BoxFit.cover,
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        offset: Offset(0, 4),
                                        blurRadius: 4,
                                        color: Color.fromARGB(70, 0, 0, 0),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(
                                singleProduct.name,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'merienda',
                                    color: Palette.col),
                              ),
                            ),
                            singleProduct.prevprice.isNotEmpty
                                ? SizedBox(
                                    width: 100,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          singleProduct.prevprice,
                                          style: const TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              decorationThickness: 2,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.red,
                                              fontFamily: 'merienda'),
                                        ),
                                        CustomText(
                                          text:
                                              "\$${singleProduct.price.toString()}",
                                          color: Palette.col,
                                          size: 12,
                                        )
                                      ],
                                    ),
                                  )
                                : CustomText(
                                    text: "\$${singleProduct.price.toString()}",
                                    color: Palette.col,
                                    size: 12,
                                  ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
