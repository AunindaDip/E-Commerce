import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:symbexecommerce/Controller/Cart_controller.dart';
import 'package:symbexecommerce/Models/Cartmodel1.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'CartView.dart';
import 'Models/Cartmodel1.dart';
import 'Models/placeordermodel.dart';
import 'home.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class placeorder extends StatefulWidget {
  const placeorder({Key? key}) : super(key: key);
  @override
  _placeorderState createState() => _placeorderState();
}

class _placeorderState extends State<placeorder> {
  String groupvalue = "Cash On ";
  TextEditingController ordernamecontroller = TextEditingController();
  TextEditingController orderAdresscontroller = TextEditingController();
  TextEditingController zipcodecontroller = TextEditingController();
  TextEditingController ordermobilecontroller = TextEditingController();
  TextEditingController orderemailcontroller = TextEditingController();
  String status = 'ordered';

  final cartcontroller Cartcontroller = Get.find();
  var User;
  Timer? _timer;

  @override
  void initState() {
    _getuserinfo();
    super.initState();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
  }

  var box = GetStorage();

  void _getuserinfo() async {
    SharedPreferences localstorage = await SharedPreferences.getInstance();
    var userJson = localstorage.getString('user');
    var user = jsonDecode(userJson!);
    setState(() {
      User = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Order'),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen()),
                );
              }),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: ordernamecontroller,
                    decoration: InputDecoration(
                        icon: Icon(Icons.people),
                        fillColor: Colors.black,
                        hintText: 'Your Name',
                        labelText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        )),
                    validator: (text) {
                      if (text!.isEmpty) {
                        return 'please provide marks';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(),
                        child: Center(
                          child: Icon(
                            Icons.account_circle_rounded,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey, // Set border color
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.00)),
                            ),
                            child: Text(
                              "Country " + "Bangladesh",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  //fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  DropDownField(
                    icon: Icon(Icons.location_city_outlined),
                    itemsVisibleInDropdown: 5,
                    controller: cititselectd,
                    hintText: "Select Your city",
                    enabled: true,
                    required: true,
                    items: citesofbd,
                    onValueChanged: (value) {
                      setState(() {
                        value = selectcity;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: orderAdresscontroller,
                    decoration: InputDecoration(
                        icon: Icon(Icons.house),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Address',
                        labelText: 'Address',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        )),
                    validator: (text) {
                      if (text!.isEmpty) {
                        return 'please provide marks';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: zipcodecontroller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        icon: Icon(Icons.air),
                        hintText: 'Zip Code',
                        labelText: 'Zip Code',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        )),
                    validator: (text) {
                      if (text!.isEmpty) {
                        return 'please provide marks';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: ordermobilecontroller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        icon: Icon(Icons.mobile_friendly_outlined),
                        hintText: 'Mobile',
                        labelText: 'Mobile Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        )),
                    validator: (text) {
                      if (text!.isEmpty) {
                        return 'please provide marks';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: orderemailcontroller,
                    decoration: InputDecoration(
                        icon: Icon(Icons.email),
                        hintText: 'Email',
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        )),
                    validator: (text) {
                      if (text!.isEmpty) {
                        return 'please provide marks';
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      Radio(
                        value: "Cash On Delivery ",
                        groupValue: groupvalue,
                        onChanged: (value) {
                          setState(() {
                            groupvalue = value.toString();
                          });
                        },
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text("Cash On Delivery"),
                      Radio(
                        value: "Pay Now",
                        groupValue: groupvalue,
                        onChanged: (value) {
                          setState(() {
                            groupvalue = value.toString();
                          });
                        },
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text("Pay Now"),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Expanded(
                          child: RaisedButton(
                        onPressed: () {
                          if (ordernamecontroller.text.isEmpty ||
                              orderAdresscontroller.text.isEmpty ||
                              zipcodecontroller.text.isEmpty ||
                              ordermobilecontroller.text.isEmpty ||
                              ordermobilecontroller.text.isEmpty ||
                              groupvalue == "Cash On") {
                            Fluttertoast.showToast(
                                msg: "You have to Fill out the full form ",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else if (ordernamecontroller.text.isNotEmpty &&
                              orderAdresscontroller.text.isNotEmpty &&
                              zipcodecontroller.text.isNotEmpty &&
                              ordermobilecontroller.text.isNotEmpty &&
                              ordermobilecontroller.text.isNotEmpty &&
                              groupvalue.contains("Cash On Delivery")) {
                            print(jsonEncode(Cartcontroller.cart));
                            plceorder(Cartcontroller.cart);

                          } else if (ordernamecontroller.text.isNotEmpty &&
                              orderAdresscontroller.text.isNotEmpty &&
                              zipcodecontroller.text.isNotEmpty &&
                              ordermobilecontroller.text.isNotEmpty &&
                              ordermobilecontroller.text.isNotEmpty &&
                              groupvalue.contains("Pay Now")) {
                            Onlinepay(Cartcontroller.cart);
                          }
                        },
                        color: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.00),
                          side: const BorderSide(color: Colors.white),
                        ),
                        child: const Text(
                          "Place Order",
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void plceorder(RxList<cartmodel1> cart) async {



    Ordermodel  ordermodel= Ordermodel(
      user_id: User['id'].toString(),
      subtotal:  Cartcontroller.SumCart().toString(),
      discount: "0",
      tax: "0",
      total:Cartcontroller.SumCart().toString(),
      firstname: ordernamecontroller.text,
      lastname: " ",
      email: orderemailcontroller.text,
      mobile: ordermobilecontroller.text,
      address: orderAdresscontroller.text,
      country: "Bangladesh",
      zipcode: zipcodecontroller.text,
      city: cititselectd.text,
      status: 'ordered',
      ship_to_different: '1',
      transaction_id:"",
      approve_status: "0",
      payment_status:"",
      currency:" ",
      order_items: Cartcontroller.cart.toList(),





    );

    var url = Uri.parse("https://ecommerce.symbexit.com/api/order");
   print(ordermodel.tojson());

   EasyLoading.show(status: "sending..");
    var response = await http.post(url,
      headers: {
      "Content-type":"application/json"
        },
      body:json.encode(ordermodel.tojson()),
    );






    if (response.statusCode == 201) {

      EasyLoading.showSuccess("Your Order has ben placed ");
      Navigator.pop(context);
      EasyLoading.dismiss();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const homepage()),
      );

      Cartcontroller.cart.remove(Cartcontroller.cart);
      save(Cartcontroller.cart);



    } else {




     EasyLoading.dismiss();

    }




  }

  void save(RxList<cartmodel1> cart) {
    box.write('MY_CART_KEY', jsonEncode(cart));
    Cartcontroller.Clearcart();
  }

  void Onlinepay(RxList<cartmodel1> cart) async {
    int otp = Random().nextInt(999999);
    int noOfOtpDigit = 6;
    while (otp
        .toString()
        .length != noOfOtpDigit) {
      otp = Random().nextInt(999999);
    }
    String otpString = otp.toString();


    void save(RxList<cartmodel1> cart) {
      box.write('MY_CART_KEY', jsonEncode(cart));
      Cartcontroller.Clearcart();
    }


    Sslcommerz ddd = Sslcommerz(
        initializer: SSLCommerzInitialization(
            ipn_url: "https://www.ecommerce.symbexit.com/api/ipn",
            store_id: "sym616d499239c50",
            store_passwd: "sym616d499239c50@ssl",
            total_amount: Cartcontroller.SumCart(),
            currency: SSLCurrencyType.BDT,
            tran_id: otpString,
            product_category: "hello",
            sdkType: "SSLCSdkType.TESTBOX"));

    var result = await ddd.payNow();
    if (result is PlatformException) {
      print("the response is: " +
          result.message.toString() +
          " code: " +
          result.code);
    } else {
      SSLCTransactionInfoModel model = result;


      Ordermodel ordermodel = Ordermodel(
        user_id: User['id'].toString(),
        subtotal: Cartcontroller.SumCart().toString(),
        discount: "0",
        tax: "0",
        total: Cartcontroller.SumCart().toString(),
        firstname: ordernamecontroller.text,
        lastname: " ",
        email: orderemailcontroller.text,
        mobile: ordermobilecontroller.text,
        address: orderAdresscontroller.text,
        country: "Bangladesh",
        zipcode: zipcodecontroller.text,
        city: cititselectd.text,
        status: 'ordered',
        approve_status: "0",
        payment_status:"",
        currency:" ",
        ship_to_different: '1',
        transaction_id: otpString,
        order_items: Cartcontroller.cart.toList(),


      );

      var url = Uri.parse("https://ecommerce.symbexit.com/api/order");
      print(ordermodel.tojson());

      EasyLoading.show(status: "sending..");
      var response = await http.post(url,
        headers: {
          "Content-type": "application/json"
        },
        body: json.encode(ordermodel.tojson()),
      );


      if (response.statusCode == 201) {
        EasyLoading.showSuccess("Your Order has ben placed ");
        Navigator.pop(context);
        EasyLoading.dismiss();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const homepage()),
        );

        Cartcontroller.cart.remove(Cartcontroller.cart);
        save(Cartcontroller.cart);

      } else {


        //EasyLoading.show(status: response.body.toString());
        EasyLoading.dismiss();
      }
    }
  }

  }

String selectcity = " ";
final cititselectd = TextEditingController();

List<String> citesofbd = [
  "Dhaka", "Faridpur", "Gazipur", "Gopalganj", "Jamalpur", "Kishoreganj", "Madaripur", "Manikganj",
  "Munshiganj", "Mymensingh", "Narayanganj", "Narsingdi", "Netrokona", "Rajbari", "Shariatpur",
  "Sherpur", "Tangail", "Bogra", "Joypurhat", "Naogaon", "Natore", "Nawabganj", "Pabna", "Rajshahi",
  "Sirajgonj", "Dinajpur", "Gaibandha", "Kurigram", "Lalmonirhat", "Nilphamari", "Panchagarh", "Rangpur",
  "Thakurgaon", "Barguna", "Barisal", "Bhola", "Jhalokati", "Patuakhali", "Pirojpur", "Bandarban", "Brahmanbaria",
  "Chandpur", "Chittagong", "Comilla", "Cox's Bazar", "Feni", "Khagrachari", "Lakshmipur", "Noakhali", "Rangamati",
  "Habiganj", "Maulvibazar", "Sunamganj", "Sylhet", "Bagerhat", "Chuadanga", "Jessore", "Jhenaidah", "Khulna", "Kushtia",
  "Magura", "Meherpur", "Narail", "Satkhira",
];
