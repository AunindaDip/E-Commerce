import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/My_Order_Items.dart';
import 'package:http/http.dart' as http;

class myorederedprouctlist extends StatefulWidget {
  final String id;

  const myorederedprouctlist(
    String catagoryid, {
    Key? key,
    required this.id,
  }) : super(key: key);
  @override
  _myorederedprouctlistState createState() => _myorederedprouctlistState(id);
}

class _myorederedprouctlistState extends State<myorederedprouctlist> {
  _myorederedprouctlistState(id);
  var User;
  @override
  void initState() {
    _getuserinfo();
    super.initState();
  }

  void _getuserinfo() async {
    SharedPreferences localstorage = await SharedPreferences.getInstance();
    var userJson = localstorage.getString('user');
    var user = jsonDecode(userJson!);
    setState(() {
      User = user;
    });
    print(User['id']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("E Comeerce")),
      body: Container(
        child: FutureBuilder(
            future: _getitems( widget.id.toString()),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Padding(
                    padding: EdgeInsets.all(100.0),
                    child: Center(
                      child: Text(
                        "Wait While Loading Data...",
                        style: TextStyle(color: Colors.black, fontSize: 30),
                      ),
                    ));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int Index) {
                    var c =
                        double.parse(snapshot.data[Index].product.salePrice);

                    //double.parse(
                    //snapshot.data[Index].product.salePrice.toString());
                    var a = double.parse(snapshot.data[Index].quantity) * c;
                    var d = a.toString();

                    return Container(
                      height: 100,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              'https://ecommerce.symbexit.com/assets/images/products/' +
                                  snapshot.data[Index].product.image.toString(),
                            ),
                          ),
                          Expanded(
                              child: Container(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    snapshot.data[Index].product.name
                                            .toString() +
                                        "\n" +
                                        //snapshot.data[Index].product.salePrice+

                                        NumberFormat.currency(
                                                decimalDigits: 2,
                                                locale: "en-in")
                                            .format(int.parse(snapshot
                                                .data[Index].product.salePrice
                                                .toString()
                                                .replaceAll(".00", '')))
                                            .replaceAll("INR", "TK.") +
                                        " x " +
                                        snapshot.data[Index].quantity +
                                        " = " +
                                        NumberFormat.currency(
                                                decimalDigits: 2,
                                                locale: "en-in")
                                            .format(int.parse(d
                                                .toString()
                                                .replaceAll(".0", '')))
                                            .replaceAll("INR", "TK."),
                                    style:
                                        const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ))
                        ],
                      ),
                    );
                  },
                );
              }
            }),
      ),
    );
  }
}

Future<List<myorderitem>> _getitems(String  id) async {
  var url = Uri.parse("https://www.ecommerce.symbexit.com/api/viewOrderitem");
  var data = await http.get(url);
  var jsonData = json.decode(data.body);
  final list = jsonData as List<dynamic>;
  print(list);
  return list
      .map((e) => myorderitem.fromJson(e))
      .where((element) =>
          element.orderId.toString() == id.toString())
      .toList();
}
