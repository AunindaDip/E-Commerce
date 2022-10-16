import 'dart:convert';
import 'package:flutter/material.dart';
import '../Models/My_Order_Items.dart';
import 'package:http/http.dart' as http;

class myorederedprouctlist extends StatelessWidget {
  const myorederedprouctlist(
      String catagoryid, {
        Key? key,
        required this.id,
      }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("E Comeerce")
      ),
      body: Container(
        child: FutureBuilder(
            future: _getitems(id),
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
                    return Row(
                      children: [
                        Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white12,

                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                              ),
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snapshot.data[Index].product.name,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                      )),
                                  Text("1 *" + snapshot.data[Index].quantity,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                      )),
                                  Text((double.parse(snapshot
                                      .data[Index].product.salePrice) *
                                      double.parse(
                                          snapshot.data[Index].quantity))
                                      .toString()),
                                ],
                              ),
                            ))
                      ],
                    );
                  },
                );
              }
            }
            ),
      ),
    );
  }
}

Future<List<myorderitem>> _getitems(String id) async {
  var url = Uri.parse("https://www.ecommerce.symbexit.com/api/viewOrderitem");
  var data = await http.get(url);
  var jsonData = json.decode(data.body);
  final list = jsonData as List<dynamic>;
  print(list);
  return list
      .map((e) => myorderitem.fromJson(e))
      .where((element) => element.orderId!.toString().contains(id))
      .toList();
}
