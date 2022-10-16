class myorders {
  int? id;
  int? userId;
  String?transaction_id;
  String? subtotal;
  String? discount;
  String? tax;
  String? total;
  String? firstname;
  String? lastname;
  String? mobile;
  String? email;
  String? address;
  String? line2;
  String? city;
  String? province;
  String? country;
  String? zipcode;
  String? status;
  String? approveStatus;
  String? shipToDifferent;
  String? createdAt;
  String? updated_at;
  String? deliveredDate;
  String? canceledDate;
  String? ProcessingDate;
  String? on_the_way_date;

  myorders(
      {
        this.id,
        this.userId,
        this.transaction_id,
        this.subtotal,
        this.discount,
        this.tax,
        this.total,
        this.firstname,
        this.lastname,
        this.mobile,
        this.email,
        this.address,
        this.line2,
        this.city,
        this.province,
        this.country,
        this.zipcode,
        this.status,
        this.approveStatus,
        this.shipToDifferent,
        this.createdAt,
        this.updated_at,
        this.deliveredDate,
        this.canceledDate,
        this.ProcessingDate,
        this.on_the_way_date
      }
      );

  myorders.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    userId = json['user_id'];
    transaction_id=json['transaction_id'];
    firstname = json['firstname'];
    subtotal=json['subtotal'];
    total=json['total'];
    lastname=json['lastname'];
    status=json['status'];
    mobile=json['mobile'];
    city=json['city'];
    country=json['country'];
    approveStatus=json['approve_Status'];
    createdAt=json['created_at'];
    updated_at=json['updated_at'];
    deliveredDate=json['delivered_date'];
    ProcessingDate=json['processing_date'];
    on_the_way_date=json['on_the_way_date'];


  }

  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['transaction_id']=transaction_id;
    data['subtotal'] = subtotal;
    data['discount'] = discount;
    data['tax'] = tax;
    data['total'] = total;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['mobile'] = mobile;
    data['email'] = email;
    data['address'] = address;
    data['line2'] = line2;
    data['city'] = city;
    data['province'] = province;
    data['country'] = country;
    data['zipcode'] = zipcode;
    data['status'] = status;
    data['approve_status'] = approveStatus;
    data['ship_to_different'] = shipToDifferent;
    data['created_at'] = createdAt;
    data['updated_at'] = updated_at;
    data['delivered_date'] = deliveredDate;
    data['canceled_date'] = canceledDate;
    data['total']=total;
    data['processing_date']=ProcessingDate;
    data['on_the_way_date']=on_the_way_date;
    return data;
  }
}