import 'dart:convert';
import 'package:flutter/material.dart';
import 'Models/ModelforCatagory.dart';
import 'package:http/http.dart' as http;
import 'CatagorWiseProductlist.dart';

class HorizontalList extends StatefulWidget {
  const HorizontalList({Key? key}) : super(key: key);

  @override
  _HorizontalListState createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: FutureBuilder(
        future: fetchcatagories(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text("Something Went Wrong"),
              ),
            );
          } else {}
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int Index) {
                return SizedBox(
                  height: 100,
                  width: 100,
                  child: InkWell(
                    onTap: () {
                      String catagoryid = snapshot.data[Index].id;
                      String catgoryname = snapshot.data[Index].name;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => products1(
                                    catagoryid,
                                    catgoryname,
                                    id: catagoryid,
                                    appbarname: catgoryname,
                                  )));
                    },
                    child: Wrap(
                      children: [
                        Image.asset("assets/images/ca2.png"),
                        ListTile(
                          title: Text(
                            snapshot.data[Index].name,
                            style: const TextStyle(
                                fontSize: 11, fontWeight: FontWeight.bold),
                            maxLines: 3,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}

Future<List<Catgaoeymoel>> fetchcatagories() async {
  var url = Uri.parse("https://ecommerce.symbexit.com/api/category");
  var data = await http.get(url);
  var jsonData = json.decode(data.body);
  List<Catgaoeymoel> dip = [];
  for (var u in jsonData) {
    Catgaoeymoel modelproducts =
        Catgaoeymoel(u["id"].toString(), u["name"], u["slug"]);
    dip.add(modelproducts);
  }
  return dip;
}
