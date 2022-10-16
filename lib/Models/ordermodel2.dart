import 'Cartmodel1.dart';

class ordermodel2 {
  List<cartmodel1> cartitemlist2 = [];

  ordermodel2({required this.cartitemlist2});

  ordermodel2.fromJson(Map<String, dynamic> json) {
    if (json['cartitemlist2'] != null) {
      json['cartitemlist2'].forEach((v) {
        cartitemlist2.add(cartmodel1.fromjson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['cartitemlist2'] = cartitemlist2.map((v) => v.toJson()).toList();
    return data;
  }
}
