import 'package:flutter/cupertino.dart';
import 'package:symbexecommerce/Controller/Cart_controller.dart';

class TotalcartItem extends StatelessWidget {
  String text = '', value = '';

  TotalcartItem(
      {
        required this.text,
        required this.value,
        required this.isSubtotal,
        required this.controller
      }
      );

  bool isSubtotal = false;
  final cartcontroller controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(text), Text(value.toString())],
    );
  }
}
