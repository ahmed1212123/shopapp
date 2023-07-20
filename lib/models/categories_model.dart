class CategoriesModel
{
  late bool status ;
  late CategoriesData data;
  Map<String,dynamic>? json;
  CategoriesModel.fromJson(json)
  {
    status = json['status'];
    data = CategoriesData.fromJson(json['data']);
  }
}

class CategoriesData
{
  late int current_page;
  late String first_page_url;
  late int from;
  late int last_page;
  late String last_page_url;
  late String path ;
  late int per_page;
  late int to;
  late int total;
  late List<DataOnData> data=[];
  Map<String,dynamic>? json;
  CategoriesData.fromJson(json)
  {
    current_page = json['current_page'];
    first_page_url = json['first_page_url'];
    from = json['from'];
    last_page = json['last_page'];
    last_page_url = json['last_page_url'];
    path = json['path'];
    per_page = json['per_page'];
    to = json['to'];
    total = json['total'];
    json['data'].forEach((element){
      data.add(DataOnData.fromJson(element));
    });

  }
  //late String next_page_url;
}
class DataOnData
{
  late int id;
  late String name;
  late String image;
  Map<String,dynamic>? json;
  DataOnData.fromJson(json)
  {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}