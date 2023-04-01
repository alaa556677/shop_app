class CategoriesModel{
  bool? status;
  CategoriesDataModel? data ;

  CategoriesModel.fromJson(Map <String,dynamic>json){
    status = json['status'];
    data = json['data'] == null ? null : CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel{
  int? currentPage;
  List <CategoriesDataList>? data = [] ;
  CategoriesDataModel.fromJson(Map <String,dynamic>json){
    currentPage = json['current_page'];
    json['data'].forEach((e){
      data?.add( CategoriesDataList.fromJson(e));
    });
  }
}

class CategoriesDataList{
  int id = 0;
  String name = '';
  String image = '';
  CategoriesDataList.fromJson(Map <String,dynamic>json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}