class SettingsModel{
  bool? status;
  SettingsData? data;
  SettingsModel.fromJson(Map<String,dynamic>json){
   status = json['status'];
   data = json['data']==null?null:SettingsData.fromJson(json['data']);
  }
}

class SettingsData{
  int id = 0 ;
  String name = '' ;
  String email = '' ;
  String phone = '' ;
  String image = '' ;
  int points = 0 ;
  int credit = 0 ;
  String token = '' ;

  SettingsData.fromJson(Map<String,dynamic>json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }

}