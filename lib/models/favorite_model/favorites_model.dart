class FavoritesModel{
  bool? status;
  String? message;
  FavoritesDataModel? data;
  FavoritesModel.fromJson(Map<String,dynamic>json){
    status = json['status'];
    message = json['message'];
    data = FavoritesDataModel.fromJson(json['data']);
  }
}

class FavoritesDataModel{
  int? currentPage ;
  List <FavoritesData> data = [];
  FavoritesDataModel.fromJson(Map<String,dynamic>json){
    currentPage = json['id'];
    json['data'].forEach((e){
      data.add(FavoritesData.fromJson(e));
    });
  }
}

class FavoritesData{
  int? id;
  Product? product;
  FavoritesData.fromJson(Map<String,dynamic>json){
    id = json['id'];
    product = Product.fromJson(json['product']);
  }
}

class Product{
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String name =' ';
  Product.fromJson(Map<String,dynamic>json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
  }
}

