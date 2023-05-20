import 'package:e_shop_admin/constants/colors.dart';
import 'package:e_shop_admin/models/product_model.dart';
import 'package:e_shop_admin/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final ProductModel singleProduct;
  const Details({super.key, required this.singleProduct});
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Palette.col,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Image
                SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: Stack(
                    children: [
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      NetworkImage(widget.singleProduct.image),
                                  fit: BoxFit.fitHeight),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: widget.singleProduct.name,
                              color: Palette.col,
                              size: 20,
                            ),
                            CustomText(
                              text:
                                  "\$${widget.singleProduct.price.toString()}",
                              color: Palette.col,
                              size: 20,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Text(
                                widget.singleProduct.prevprice,
                                style: const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    decorationThickness: 2,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red,
                                    fontFamily: 'merienda'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    widget.singleProduct.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Merienda',
                        fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
