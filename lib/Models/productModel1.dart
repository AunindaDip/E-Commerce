
class modelproducts2
{
  String? id;
  String? name;
  String? description;
  String ?salePrice;
  String? stockStatus;
  String? image;
  String? categoryId;

  modelproducts2(

      {
    this.id,
    this.name,
    this.description,
    this.salePrice,
    this.stockStatus,
    this.image,
    this.categoryId,
  }
  );

  modelproducts2.fromJson(Map<String, dynamic> json)
  {
    id = json['id'].toString() ;
    name = json['name'].toString();
    description = json['description'].toString();
    salePrice = json['sale_price'].toString();
    stockStatus = json['stock_status'].toString();
    image = json['image'].toString();
    categoryId = json['category_id'].toString();
  }

  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['sale_price'] = salePrice;
    data['stock_status'] = stockStatus;
    data['image'] = image;
    data['category_id'] = categoryId;
    return data;
  }
}



