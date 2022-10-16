import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/show_order_model.dart';
import 'Cash_ON_Delivery.dart';
import 'Paid_Delivery.dart';
import '../home.dart';
import 'SearchMyOrder.dart';

class orderview extends StatefulWidget {
  final String id;

  const orderview(String uid, {Key? key, required this.id}) : super(key: key);

  @override
  _orderviewState createState() => _orderviewState(id);
}

class _orderviewState extends State<orderview> {
  _orderviewState(id);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: InkWell(
                onTap: (){
                  showSearch(
                      context: context, delegate: SearchOrder(widget.id));
                },
                child: Container(
              width: MediaQuery.of(context).size.width * .9,



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
                        child: const Text("Search order by OrderID ",
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

              leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const homepage()),
                    );
                  }),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                        context: context, delegate: SearchOrder(widget.id));
                  },
                )
              ],
              bottom: const TabBar(
                indicatorColor: Colors.white,
                indicatorWeight: 5,
                tabs: [
                  Tab(icon: Icon(Icons.book_online), text: "Cash ON Delivery"),
                  Tab(icon: Icon(Icons.wb_sunny_rounded), text: "Paid Order"),
                ],
              ),
              elevation: 20,
              titleSpacing: 20,
            ),
            body: TabBarView(children: [
              RefreshIndicator(
                child: builpageCod(widget.id),
                onRefresh: () {
                  setState(() {});
                  return _getOrders(widget.id);
                },
              ),
              RefreshIndicator(
                onRefresh: () {
                  setState(() {});
                  return _getpaidOrders(widget.id);
                },
                child: buildpagePaid(widget.id),
              )
            ]),
          )),
    );
  }
}

Future<List<myorders>> _getOrders(String a) async {
  var url = Uri.parse('https://www.ecommerce.symbexit.com/api/viewOrder');
  var data = await http.get(url);
  var jsonData = jsonDecode(data.body);
  final list = jsonData as List<dynamic>;

  return list
      .map((e) => myorders.fromJson(e))
      .where((element) =>
          element.transaction_id == null &&
          element.userId!.toString().contains(a))
      .toList();
}

Future<List<myorders>> _getpaidOrders(String a) async {
  var url = Uri.parse('https://www.ecommerce.symbexit.com/api/viewOrder');
  var data = await http.get(url);
  var jsonData = jsonDecode(data.body);
  final list = jsonData as List<dynamic>;
  return list
      .map((e) => myorders.fromJson(e))
      .where((element) =>
          element.transaction_id != null &&
          element.userId!.toString().contains(a))
      .toList();
}
