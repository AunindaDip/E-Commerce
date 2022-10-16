class myorderitem {
  String? user_id;
  String? id;
  String? productId;
  String? orderId;
  String? price;
  String? quantity;
  String? createdAt;
  String? updatedAt;
  Product? product;
  String? transaction_id;

  myorderitem(

      {this.id,
      this.productId,
      this.orderId,
      this.price,
      this.quantity,
      this.createdAt,
      this.updatedAt,
      this.product,
      this.transaction_id,
      this.user_id
      }
      );

  myorderitem.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    productId = json['product_id'].toString();
    orderId = json['order_id'].toString();
    price = json['price'].toString();
    quantity = json['quantity'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    transaction_id = json['transaction_id'].toString();
    user_id=json['user_id'].toString();
    product =
        json['product'] !=null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['order_id'] = orderId;
    data['price'] = price;
    data['quantity'] = quantity;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['transaction_id'] = transaction_id;
    data['user_id']=user_id;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class Product {
  String? id;
  String? name;
  String? slug;
  String? shortDescription;
  String? description;
  String? regularPrice;
  String? salePrice;
  String? sKU;
  String? stockStatus;
  String? featured;
  String? quantity;
  String? image;
  String? images;
  String? categoryId;
  String? createdAt;
  String? updatedAt;
  String? filename;

  Product(
      {this.id,
      this.name,
      this.slug,
      this.shortDescription,
      this.description,
      this.regularPrice,
      this.salePrice,
      this.sKU,
      this.stockStatus,
      this.featured,
      this.quantity,
      this.image,
      this.images,
      this.categoryId,
      this.createdAt,
      this.updatedAt,
      this.filename});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    slug = json['slug'].toString();
    shortDescription = json['short_description'].toString();
    description = json['description'].toString();
    regularPrice = json['regular_price'].toString();
    salePrice = json['sale_price'].toString();
    sKU = json['SKU'].toString();
    stockStatus = json['stock_status'].toString();
    featured = json['featured'].toString();
    quantity = json['quantity'].toString();
    image = json['image'].toString();
    images = json['images'].toString();
    categoryId = json['category_id'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    filename = json['filename'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['short_description'] = shortDescription;
    data['description'] = description;
    data['regular_price'] = regularPrice;
    data['sale_price'] = salePrice;
    data['SKU'] = sKU;
    data['stock_status'] = stockStatus;
    data['featured'] = featured;
    data['quantity'] = quantity;
    data['image'] = image;
    data['images'] = images;
    data['category_id'] = categoryId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['filename'] = filename;
    return data;
  }
}
