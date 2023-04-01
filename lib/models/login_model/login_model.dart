class LoginModel{
  late bool status;
  late String message;
  late UserData? data;
  LoginModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'];
    data = json['data']==null?null:UserData.fromJson(json['data']);
  }
}

class UserData{
  int id = 0;
  String name = 'name';
  String email = 'email';
  String phone = 'phone';
  String image = 'image';
  int points = 0;
  int credit = 0;
  String token = 'token';

  UserData.fromJson(Map <String , dynamic> json) {
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

