class ChangeFavoritesModel
{
  late bool status;
  late String message;
  Map<String,dynamic>? json;
  ChangeFavoritesModel.fromJson(json)
  {
    status = json['status'];
    message=json['message'];
  }
}