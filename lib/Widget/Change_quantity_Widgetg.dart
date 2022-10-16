import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';
import 'package:symbexecommerce/Controller/Cart_controller.dart';
import 'package:symbexecommerce/Models/Cartmodel1.dart';

class ChangeQuantityWidget extends StatelessWidget {
  final cartcontroller controller;
  int Index;

  ChangeQuantityWidget({required this.controller, required this.Index});

  @override
  Widget build(BuildContext context) {
    return ElegantNumberButton(
        initialValue: controller.cart[Index].quantity,
        minValue: 1,
        maxValue: 99,
        buttonSizeHeight: 40,
        buttonSizeWidth: 40,
        color: Colors.white10,
        textStyle: const TextStyle(
            color: Colors.deepOrangeAccent,
            fontSize: 20,
            fontFamily: 'avenir',
            fontWeight: FontWeight.w800),
        onChanged: (value) async {
          controller.cart[Index].quantity = value.toInt();
          saveDatabse(controller.cart);
          controller.cart.refresh();
        },
        decimalPlaces: 0);
  }
}

void saveDatabse(RxList<cartmodel1> cart) {
  var box = GetStorage();
  box.write('MY_CART_KEY', jsonEncode(cart));
}
