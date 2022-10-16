import 'dart:convert';

import 'Cartmodel1.dart';

class Ordermodel {
  String? user_id,
      subtotal,
      discount,
      tax,
      total,
      firstname,
      lastname,
      email,
      mobile,
      address,
      country,
      zipcode,
      city,
      status,
      ship_to_different,
      transaction_id,
      approve_status,
      payment_status,
      currency;



  List<cartmodel1> order_items = [];

  Ordermodel({
    this.user_id,
    required this.subtotal,
    required this.discount,
    required this.tax,
    required this.total,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.mobile,
    required this.address,
    required this.country,
    required this.zipcode,
    required this.city,
    required this.status,
    required this.ship_to_different,
    required this.transaction_id,
    required this.order_items,
    required this.approve_status,
    required this.payment_status,
    required this.currency
  });

  Ordermodel.fromjsoon(Map<String, dynamic> jsonString) {
    user_id = jsonString["user_id"];
    subtotal = jsonString["subtotal"];
    discount = jsonString["discount"];
    tax = jsonString["tax"];
    total = jsonString["total"];
    firstname = jsonString["firstname"];
    lastname = jsonString["lastname"];
    email = jsonString["email"];
    mobile = jsonString["mobile"];
    address = jsonString["address"];
    country = jsonString["country"];
    zipcode = jsonString["zipcode"];
    city = jsonString["city"];
    status = jsonString['status'];
    approve_status=jsonString['approve_status'];
    payment_status=jsonString['payment-status'];
    currency=jsonString['currency'];
    ship_to_different = jsonString["ship_to_different"];
    transaction_id = jsonString['transaction_id'];
    if (jsonString['cartitemlist2'] != null) {
      jsonString['cartitemlist2'].forEach((v) {
        order_items.add(cartmodel1.fromjson(v));
      });
    }
  }
  Map<String, dynamic> tojson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data["user_id"] = this.user_id.toString();
    data["subtotal"] = this.subtotal.toString();
    data["discount"] = this.discount.toString();
    data["tax"] = this.tax.toString();
    data["total"] = this.total.toString();
    data["firstname"] = this.firstname.toString();
    data["lastname"] = this.lastname.toString();
    data["email"] = this.email.toString();
    data["mobile"] = this.mobile.toString();
    data["address"] = this.address.toString();
    data["country"] = this.country.toString();
    data["zipcode"] = this.zipcode.toString();
    data["city"] = this.city.toString();
    data["status"] = this.status.toString();
    data['approve_status']=this.approve_status.toString();
    data['payment_status']=this.payment_status.toString();
    data['currency']=this.currency.toString();
    data['ship_to_different'] = this.ship_to_different.toString();
    data['transaction_id'] = this.transaction_id.toString();
    data['OrderItem'] = order_items.map((v) => v.toJson()).toList();
    return data;
  }
}
