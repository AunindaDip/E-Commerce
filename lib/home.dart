import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:symbexecommerce/Controller/Cart_controller.dart';
import 'package:symbexecommerce/MyOrders/My_Orders.dart';
import 'package:symbexecommerce/login.dart';
import 'package:badges/badges.dart';
import 'MyOrders/SearchMyOrder.dart';
import 'SearchMyProduct.dart';
import 'slidecarasol.dart';
import 'horizontalcatgoreylist.dart';
import 'package:symbexecommerce/products.dart';
import 'CartView.dart';
import 'topofdrwaer.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  late SharedPreferences sharedPreferences;
  var User;
  final cartcontroller Cartcontroller = Get.find();

  @override
  void initState() {
    super.initState();
    checkloginstatus();
    _getuserinfo();
  }

  checkloginstatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => const login()),
          (Route<dynamic> route) => false);
    }
  }

  void _getuserinfo() async {
    SharedPreferences localstorage = await SharedPreferences.getInstance();
    var userJson = localstorage.getString('user');
    var user = jsonDecode(userJson!);
    setState(() {
      User = user;
    });
  }

  Future<bool?> showWarnig(BuildContext context) async => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Do You Want To Exit "),
          actions: [
            ElevatedButton(
              child: const Text("No"),
              onPressed: () => Navigator.pop(context, false),
            ),
            ElevatedButton(
              child: const Text("Yes"),
              onPressed: () => SystemNavigator.pop(),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final sholdpop = await showWarnig(context);
        return sholdpop ?? false;
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            sharedPreferences.clear();
            sharedPreferences.commit();
            Navigator.pushAndRemoveUntil(
                this.context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const login()),
                (Route<dynamic> route) => false);
          },
          child: const Icon(CupertinoIcons.cart),
          backgroundColor: Colors.deepPurple,
        ),
        appBar: AppBar(
          title: InkWell(
            onTap: (){
              showSearch(
                  context: context, delegate: searchproduct());
            },
            child: Container(
              width: MediaQuery.of(context).size.width *.9000,



              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0)),
              ),




              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text("Search Product ",
                      style:TextStyle(
                          fontSize: 16,
                          color: Colors.black
                      )),
                ),

              ),

            ),
          ),
          shape: ContinuousRectangleBorder(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(90.0),
            ),),
          actions: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);

                print(jsonEncode(Cartcontroller.cart.toJson()));
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Badge(
                  badgeContent:
                      Obx(() => Text(Cartcontroller.cart.length.toString(),style:
                        TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                  child: Icon(Icons.shopping_cart),
                  badgeColor: Colors.deepOrange,
                  position: BadgePosition.topEnd(),
                  animationType: BadgeAnimationType.fade,

                ),
              ),
            )
          ],
        ),
        body: SafeArea(
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: ListView(
              children: <Widget>[
                imagecarasol,
                const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    'Catagories',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurpleAccent,
                        fontSize: 18),
                  ),
                ),
                const HorizontalList(),
                const SizedBox(
                  height: 0,
                ),
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    'Products',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurpleAccent,
                        fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 340,
                  child: products(),
                )
              ],
            ),
          ),
        ),
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  myprofildrwaer(),
                  myDrwaerlist(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  myDrwaerlist() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton.icon(
            icon: Icon(
              Icons.star_border_sharp,
              color: Colors.black,
            ),
            onPressed: () {
              String Uid = User['id'].toString();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => orderview(
                          Uid,
                          id: Uid,
                        )),
              );
            },
            label: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "My Orders ",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          TextButton.icon(
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              ),
              onPressed: () {
                sharedPreferences.clear();
                sharedPreferences.commit();
                Cartcontroller.Clearcart();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const login()
                    ),
                    (Route<dynamic> route) => false);
              },
              label: const Text(
                "SignOut",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16),
              )),
          TextButton.icon(
              icon: Icon(
                Icons.animation,
                color: Colors.black,
              ),
              onPressed: () {},
              label: const Text(
                "My Profile",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16),
              )
          ),
          TextButton.icon(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              label: const Text(
                "Cart",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16),
              ),
          ),
        ],
      ),
    );
  }
}
