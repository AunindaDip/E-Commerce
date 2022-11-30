
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:symbexecommerce/Models/productModel1.dart';
import 'Controller/Cart_controller.dart';
import 'product_details.dart';

class products extends StatefulWidget {
  const products({Key? key}) : super(key: key);

  @override
  _productsState createState() => _productsState();
}

class _productsState extends State<products> {
  final controller = Get.put(cartcontroller());

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);


  @override
  void initState() {
    Firebase.initializeApp();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
          future: fetchproducts(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.data == null) {
              return const Padding(
                  padding: EdgeInsets.all(100.0),
                  child: Center(
                    child: Text(
                      "oops...",
                      style: TextStyle(color: Colors.black, fontSize: 30),
                    ),
                  ));
            } else if (snapshot.hasData) {
              return StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  itemCount: snapshot.data.length,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, Index) {
                    return GestureDetector(
                      onTap: () {



                          controller.intializequantity();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => productdetails(
                                  Modelproducts2: snapshot.data[Index])));









                      },
                      child: Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 180,
                                    width: double.infinity,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Image.network(
                                      'https://ecommerce.symbexit.com/assets/images/products/' +
                                          snapshot.data[Index].image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                snapshot.data[Index].name ?? "dip",
                                maxLines: 2,
                                style: const TextStyle(
                                    fontFamily: 'avenir',
                                    fontWeight: FontWeight.w800),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                NumberFormat.currency(
                                        decimalDigits: 2, locale: "en-in")
                                    .format(int.parse(snapshot
                                        .data[Index].salePrice
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
                      ),
                    );
                  },
                  staggeredTileBuilder: (Index) => const StaggeredTile.fit(1));
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Something went wrong"),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}

Future<List<modelproducts2>> fetchproducts() async {
  var url = Uri.parse("https://ecommerce.symbexit.com/api/product");
  var data = await http.get(url);
  var jsonData = json.decode(data.body);
  final list = jsonData as List<dynamic>;
  return list.map((e) => modelproducts2.fromJson(e)).toList();
}

