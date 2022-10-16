import 'dart:convert';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import '../Models/show_order_model.dart';
import '../Widget/order_product.dart';

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

buildpagePaid(String id) {
  ScrollController _controller = ScrollController();
  return Container(
    child: FutureBuilder(
        future: _getpaidOrders(id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: 8,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.withOpacity(.25),
                    highlightColor: Colors.white.withOpacity(.6),
                    period: Duration(seconds: 2),
                    child: Container(
                      height: 250,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        border: Border.all(
                          color: Colors.deepPurple,
                          width: 5.0,
                        ),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  );
                });
          } else if (snapshot.data == null) {
            return const Center(
              child: Text("NONO"),
            );
          } else if (snapshot.hasData) {
            return DraggableScrollbar.arrows(
                heightScrollThumb: 100,
                alwaysVisibleScrollThumb: false,
                backgroundColor: Colors.black,
                controller: _controller,
                child: ListView.builder(
                    controller: _controller,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int Index) {
                      return SingleChildScrollView(
                        child: Row(children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white12,
                                border: Border.all(
                                  color: Colors.deepPurple,
                                  width: 5.0,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                              ),
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Order Id : " +
                                        snapshot.data[Index].id.toString(),
                                    style: const TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                      "Transaction_id : " +
                                          snapshot.data[Index].transaction_id
                                              .toString(),
                                      style: const TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                      "Contact Person : " +
                                          snapshot.data[Index].firstname ,

                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      )),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "Contact Number: " +
                                        snapshot.data[Index].mobile,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Stepper(
                                      controlsBuilder: (BuildContext context,
                                          ControlsDetails controls) {
                                        return const SizedBox.shrink();
                                      },
                                      currentStep: 0,
                                      type: StepperType.vertical,
                                      steps: <Step>[
                                        Step(
                                            title: const Text("Ordered"),
                                            content: Container(),
                                            isActive: snapshot
                                                        .data[Index].status
                                                        .toString() ==
                                                    "ordered"
                                                ? true
                                                : false,
                                            state: StepState.complete,
                                            subtitle: Text(snapshot
                                                    .data[Index].createdAt ??
                                                "")),
                                        Step(
                                            title: const Text("Processing"),
                                            content: Container(),
                                            isActive: (snapshot
                                                        .data[Index].status
                                                        .toString() ==
                                                    "processing"
                                                ? true
                                                : false),
                                            state: StepState.complete,
                                            subtitle: Text(snapshot.data[Index]
                                                    .ProcessingDate ??
                                                " ")),
                                        Step(
                                          title: const Text("On the Way"),
                                          content: Container(),
                                          isActive: snapshot.data[Index].status
                                                  .toString() ==
                                              "on_the_way",
                                          state: StepState.complete,
                                          subtitle: Text(
                                              snapshot.data[Index].on_the_way_date ??
                                                  " "),
                                        ),
                                        Step(
                                          title: const Text("Delivered"),
                                          content: Container(),
                                          isActive: snapshot.data[Index].status
                                                  .toString() ==
                                              "delivered",
                                          subtitle: Text(snapshot
                                                  .data[Index] .deliveredDate ??
                                              ""),
                                        ),
                                      ]),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RaisedButton(
                                          onPressed: () {
                                            String orderitemId =
                                                snapshot.data[Index].id.toString();

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        myorederedprouctlist(
                                                          orderitemId,
                                                          id: orderitemId,
                                                        )));
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(40.00),
                                            side: const BorderSide(color: Colors.white),
                                          ),
                                          color: Colors.deepPurple,
                                          child: const Text("Order Details",style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ]),
                      );
                    }));
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Something Went Wrong",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        }),
  );
}
