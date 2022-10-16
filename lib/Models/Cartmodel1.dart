import 'productModel1.dart';

class cartmodel1 extends modelproducts2 {
  int quantity = 0;

  cartmodel1({
    id,
    name,
    image,
    category_id,
    description,
    salePrice,
    stock_status,
    required this.quantity,
  }) : super(
            id: id,
            name: name,
            image: image,
            categoryId: category_id,
            description: description,
            salePrice: salePrice,
            stockStatus: stock_status);

  factory cartmodel1.fromjson(Map<String, dynamic> json) {
    final product = modelproducts2.fromJson(json);
    final quantity = json['quantity'];
    return cartmodel1(
        quantity: quantity,
        id: product.id,
        name: product.name,
        image: product.image,
        category_id: product.categoryId,
        description: product.description,
        salePrice: product.salePrice,
        stock_status: product.stockStatus);
  }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = id;
    data['price'] = salePrice;
    data['quantity'] = quantity;
    return data;
  }
}
