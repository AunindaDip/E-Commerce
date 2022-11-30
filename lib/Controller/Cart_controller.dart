import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:symbexecommerce/Models/Cartmodel1.dart';

class cartcontroller extends GetxController {
  var numOfitem = 1.obs;

  var cart = List<cartmodel1>.empty(growable: true).toList().obs;
  var box = GetStorage();

  SumCart() {
    return cart.isEmpty
        ? 0
        : cart
            .map((e) => double.parse(e.salePrice.toString()) * e.quantity)
            .reduce((previousValue, element) => previousValue + element);
  }

  Clearcart() {
    cart.clear();
    Savedata();
  }



  void removeitem() {
    if (numOfitem.value > 1) {
      numOfitem.value--;
    }
  }

  void additem() {
    numOfitem.value++;
  }

  void intializequantity() {
    numOfitem.value = 1;
  }

  Savedata() => {box.write('MY_CART_KEY', jsonEncode(cart))};


}
