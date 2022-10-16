import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Models/productModel1.dart';
import 'home.dart';
import 'product_details.dart';

class products1 extends StatelessWidget {
  const products1(String catagoryid, String catgoryname,
      {Key? key, required this.id, required this.appbarname})
      : super(key: key);

  final String id, appbarname;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(appbarname),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: ()
              {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const homepage()),
                );

              }

          ),

        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
              future: fetchproducts(id),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if(snapshot.data.toString().contains("[]"))
                {
                  return Center(
                    child:
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage
                            (image: AssetImage("assets/images/somthing_went_wrong.jpg"),
                          fit: BoxFit.fill)
                        ),

                      )
                    ,


                  );

                }
                if(snapshot.hasError){
                 return


                   Column(
                   children: [
                     Container(
                       decoration: const BoxDecoration(
                         image: DecorationImage(


                             image: AssetImage("assets/images/somthing_went_wrong.jpg")
                             ,
                             fit: BoxFit.contain),
                       ),

                     ),
                   ],
                 );}


                if (snapshot.hasData) {


                  return StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      itemCount: snapshot.data.length,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, Index) {
                        return GestureDetector(
                          onTap: () {
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
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      staggeredTileBuilder: (Index) => const StaggeredTile.fit(1));
                }

                return const Center(child: CircularProgressIndicator());
              }),
        ),
      ),
    );
  }
}

Future<List<modelproducts2>> fetchproducts(String asd) async {
  var url = Uri.parse("https://ecommerce.symbexit.com/api/product");
  var data = await http.get(url);
  var jsonData = json.decode(data.body);
  final list = jsonData as List<dynamic>;

  return list
      .map((e) => modelproducts2.fromJson(e))
      .where((element) => element.categoryId!.contains(asd))
      .toList();
}
