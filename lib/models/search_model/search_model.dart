class SearchModel{
  bool? status;
  String? message;
  DataModel? data;
  SearchModel.fromJson(Map<String,dynamic>json){
    status = json['status'];
    message = json['message'];
    data = json['status'] == null ? null : DataModel.fromJson(json['data']);
  }
}

class DataModel{
  int? currentPage;
  List <ProductData> dataList = [];
  DataModel.fromJson(Map<String,dynamic>json){
    currentPage = json['current_page'];
    json['data'].forEach((e){
      dataList.add(ProductData.fromJson(e));
    });
  }
}

class ProductData{
  int? id ;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  ProductData.fromJson(Map<String,dynamic>json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}