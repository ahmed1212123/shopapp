class ShopLoginModel
{
  late bool status;
  late String message;
  UserData? data;
  Map<String ,dynamic>? json;
  ShopLoginModel.fromJson(json)
  {
    status = json['status'];
    message = json['message']??'';
    data = (json['data'] != null ? UserData.fromJson(json['data']) : null)!;
    //data =  UserData.fromJson(json['data']);
  }
}
//ahmedahly12@gmail.com
class UserData{

  dynamic id;
  late String name;
  late String email;
  late String phone;
  late String image;
  dynamic point;
  dynamic credit;
  late String token;
  Map<String ,dynamic>? json;

  UserData.fromJson(json)
  {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    point = json['point'];
    credit = json['credit'];
    token = json['token'];

  }

}