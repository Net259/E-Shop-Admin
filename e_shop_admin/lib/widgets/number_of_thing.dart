import 'package:e_shop_admin/constants/colors.dart';
import 'package:e_shop_admin/controller/firebase_firestore.dart';
import 'package:e_shop_admin/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class Numbers extends StatefulWidget {
  final String textt;
  final int num;
  const Numbers({
    super.key,
    required this.textt,
    required this.num,
  });

  @override
  State<Numbers> createState() => _numbersState();
}

// ignore: camel_case_types
class _numbersState extends State<Numbers> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(blurRadius: 4, color: Colors.grey, spreadRadius: 2)
        ],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomText(
            text: widget.textt,
            color: Palette.col,
            size: 12,
          ),
          CustomText(
            text: widget.num.toString(),
            color: Palette.col,
            size: 12,
          ),
        ],
      ),
    );
  }
}
////////////////////////////////////////////////////////////////////////////////

class UserCount extends StatelessWidget {
  const UserCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: FirebaseFirestoreMethode.instance.getUserCount(),
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return Numbers(
          textt: 'Users',
          num: snapshot.data ?? 0,
        );
      },
    );
  }
}

////////////////////////////////////////////////////////////////////////////////

class CategoryCount extends StatelessWidget {
  const CategoryCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: FirebaseFirestoreMethode.instance.getCategoryCount(),
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return Numbers(
          textt: 'Categories',
          num: snapshot.data ?? 0,
        );
      },
    );
  }
}

////////////////////////////////////////////////////////////////////////////////

class ProductCount extends StatelessWidget {
  const ProductCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: FirebaseFirestoreMethode.instance.getproductCount(),
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return Numbers(
          textt: 'Products',
          num: snapshot.data ?? 0,
        );
      },
    );
  }
}

////////////////////////////////////////////////////////////////////////////////

class OrderCount extends StatelessWidget {
  const OrderCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: FirebaseFirestoreMethode.instance.getorderCount(),
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return Numbers(
          textt: 'Orders',
          num: snapshot.data ?? 0,
        );
      },
    );
  }
}
