class ShopModel {
  late bool success;
  late String message;
  late int count;
  late List<Data> data;

  ShopModel(
      {required this.success,
      required this.message,
      required this.count,
      required this.data});

  ShopModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    count = json['count'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  late String slug;
  late String contactNumber;
  late String shopName;
  late String shopImage;
  late int approval;
  late String ownerName;

  Data(
      {required this.slug,
      required this.contactNumber,
      required this.shopName,
      required this.shopImage,
      required this.approval,
      required this.ownerName});

  Data.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    contactNumber = json['contact_number'];
    shopName = json['shop_name'];
    shopImage = json['shop_image'];
    approval = json['approval'];
    ownerName = json['owner_name'];
  }

  get fromSubProducts => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slug'] = this.slug;
    data['contact_number'] = this.contactNumber;
    data['shop_name'] = this.shopName;
    data['shop_image'] = this.shopImage;
    data['approval'] = this.approval;
    data['owner_name'] = this.ownerName;
    return data;
  }
}
