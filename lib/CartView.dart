import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:symbexecommerce/Controller/Cart_controller.dart';
import 'package:symbexecommerce/home.dart';
import 'Models/Cartmodel1.dart';
import 'Order Form.dart';
import 'Widget/Change_quantity_Widgetg.dart';

class CartScreen extends StatelessWidget {
  final box = GetStorage();
  cartcontroller controller = Get.find();
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    if (controller.cart.isEmpty) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text("E-Commerce"),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const homepage()),
                  );
                }),
          ),
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 80),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .3,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/empty-cart.png"),
                      fit: BoxFit.contain),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Your cart is empty,",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Continue Shopping ",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(
                height: 30,
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const homepage()),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.00),
                  side: const BorderSide(color: Colors.white),
                ),
                color: Colors.deepPurple,
                child: const Text(
                  "Shop Now ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 45,
        width: 100,
        child: RaisedButton(
          color: Colors.deepPurple,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const placeorder()),
            );
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(80.00),
            side: const BorderSide(color: Colors.white),
          ),
          child: const Text(
            "NEXT",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const homepage()),

              );
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: const Text(
          "My Cart Items",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: controller.cart.length,
                  itemBuilder: (Context, Index) {
                    var c = double.parse(
                        controller.cart[Index].salePrice.toString());
                    var a = controller.cart[Index].quantity * c;
                    var d = a.toString();

                    return Card(
                      elevation: 40.0,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Image.network(
                              'https://ecommerce.symbexit.com/assets/images/products/' +
                                  controller.cart[Index].image.toString(),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Container(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Text(
                                      controller.cart[Index].name.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          NumberFormat.currency(
                                                  decimalDigits: 2,
                                                  locale: "en-in")
                                              .format(int.parse(controller
                                                  .cart[Index].salePrice
                                                  .toString()
                                                  .replaceAll(".00", '')))
                                              .replaceAll("INR", "TK."),
                                          style: const TextStyle(
                                              fontFamily: 'avenir',
                                              fontWeight: FontWeight.w800),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          NumberFormat.currency(
                                                  decimalDigits: 2,
                                                  locale: "en-in")
                                              .format(int.parse(
                                                  d.replaceAll(".0", '')))
                                              .replaceAll("INR", "TK."),
                                          style: const TextStyle(
                                              fontFamily: 'avenir',
                                              fontWeight: FontWeight.w800),
                                          overflow: TextOverflow.ellipsis,
                                        ),

                                        //
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: ChangeQuantityWidget(
                              controller: controller,
                              Index: Index,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("yes"),
                                        content: const Text(
                                            "Are you Sure You Want To Delete This"),
                                        titleTextStyle:
                                            const TextStyle(fontSize: 20),
                                        backgroundColor: Colors.white,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(32.0))),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CartScreen()),
                                                );
                                              },
                                              child: const Text("No")),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              controller.cart.removeAt(Index);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CartScreen()),
                                              );
                                            },
                                            child: const Text("Yes"),
                                          )
                                        ],
                                      );
                                    });
                              },
                              icon: const Icon(Icons.delete_sharp)),
                        ],
                      ),
                    );
                  }),
            ),
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Expanded(
                      child: Text(
                        "Total ",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      NumberFormat.currency(decimalDigits: 2, locale: "en-in")
                          .format(int.parse(controller.SumCart()
                              .toString()
                              .replaceAll(".0", '')))
                          .replaceAll("INR", "TK."),
                      style: const TextStyle(
                          fontFamily: 'avenir',
                          fontSize: 16,
                          fontWeight: FontWeight.w800),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Expanded(
                  child: Text(
                    "Delivery Charge ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  "0.00",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Expanded(
                  child: Text(
                    "VAT ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  "0.00",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Expanded(
                  child: Text(
                    "SubTotal ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  NumberFormat.currency(decimalDigits: 2, locale: "en-in")
                      .format(int.parse(
                          controller.SumCart().toString().replaceAll(".0", '')))
                      .replaceAll("INR", "TK."),
                  style: const TextStyle(
                      fontFamily: 'avenger',
                      fontSize: 16,
                      fontWeight: FontWeight.w800),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void saveDatabse(RxList<cartmodel1> cart) {
  var box = GetStorage();
  box.write('MY_CART_KEY', jsonEncode(cart));
  print(box.read('MY_CART_KEY'));
}
