import 'dart:convert';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:symbexecommerce/Models/productModel1.dart';
import 'Models/Cartmodel1.dart';
import 'package:symbexecommerce/Controller/Cart_controller.dart';
import 'Models/productModel1.dart';
import 'CartView.dart';

class productdetails extends StatelessWidget {
  final controller = Get.put(cartcontroller());
  final box = GetStorage();
  static const My_Cart_key = 'Cart';
  final cartcontroller Cartcontroller = Get.find();
  final modelproducts2 Modelproducts2;

  int itemcount = 1;
  productdetails({Key? key, required this.Modelproducts2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.intializequantity();
    return Scaffold(
      appBar: AppBar(
        title: Text(Modelproducts2.name ?? "No Name"),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Badge(
                badgeContent: Obx(() => Text(
                      Cartcontroller.cart.length.toString(),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                child: Icon(Icons.shopping_cart),
                badgeColor: Colors.deepOrange,
                position: BadgePosition.topEnd(),
                animationType: BadgeAnimationType.fade,
              ),
            ),
          )
        ],
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(children: <Widget>[
          Expanded(
              child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                  ),
                  child: Image.network(
                    'https://ecommerce.symbexit.com/assets/images/products/' +
                        (Modelproducts2.image ?? ''),
                  ))),
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListTile(
                title: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        Modelproducts2.name ?? 'No Name',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            (Modelproducts2.salePrice! + 'Tk'),
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const Text(
                        "About Product",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        (Modelproducts2.description ?? "No Description"),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          quantityButton(
                              icon: Icons.add,
                              press: () {
                                controller.additem();
                              }),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Obx(() => Text(
                                  controller.numOfitem.obs.toString(),
                                  style: const TextStyle(color: Colors.black),
                                )),
                          ),
                          quantityButton(
                              icon: Icons.remove,
                              press: () {
                                controller.removeitem();
                              }),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: SizedBox(
                            height: 60,
                            width: double.infinity,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              color: Colors.deepPurple,
                              onPressed: () {
                                savetocart();
                              },
                              child: const Text(
                                "Add to Cart",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            )),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void savetocart() async {
    var cartitem = cartmodel1(
      id: Modelproducts2.id,
      name: Modelproducts2.name,
      salePrice: Modelproducts2.salePrice,
      image: Modelproducts2.image,
      quantity: controller.numOfitem.toInt(),
    );
    if (isExistingincart(controller.cart, cartitem) == true) {
      Fluttertoast.showToast(
          msg: "Product Already Added To cart Please check Your Cart ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      controller.cart.add(cartitem);

      var jsonDbEncoded = jsonEncode(controller.cart);
      await box.write(My_Cart_key, jsonDbEncoded);
      controller.cart.refresh();
      Fluttertoast.showToast(
          msg: "Product Added To Cart",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  bool isExistingincart(RxList<cartmodel1> cart, cartmodel1 cartitem) {
    return cart.isEmpty
        ? false
        : cart.any((e) => e.id == cartitem.id)
            ? true
            : false;
  }
}

Widget quantityButton({required IconData icon, required Function press}) {
  return SizedBox(
      height: 30,
      width: 40,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: Colors.white,
            elevation: 20,
            minimumSize: const Size(100, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        onPressed: () {
          press();
        },
        child: Icon(icon),
      ));
}
