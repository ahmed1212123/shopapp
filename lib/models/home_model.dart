class HomeModel
{
  late bool status;
  late HomeDataModel data;
  Map<String,dynamic>? json;
  HomeModel.fromJson(json)
  {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }

}
class HomeDataModel
{
  late List<BannerModel> banners=[];
  late List<ProductModel> products=[];
  Map<String,dynamic>? json;
  HomeDataModel.fromJson(json)
  {
    json['banners']?.forEach((element)
    {
      banners.add(BannerModel.fromJson(element));
    });
    json['products']?.forEach((element)
    {
      products.add(ProductModel.fromJson(element));
    });
    // if(json['banners']!=null){
    //   banners = <BannerModel>[];
    //   json['banners'].forEach((v){
    //     banners.add(BannerModel.fromJson(v));
    //   });
    // }
    // if(json['products']!=null){
    //   products = <ProductModel>[];
    //   json['products'].forEach((v){
    //     products.add(ProductModel.fromJson(v));
    //   });
    // }
  }

}
class BannerModel
{
  late int? id;
  late String image;
  Map<String,dynamic>? json;
  BannerModel.fromJson(json)
  {
    id = json['id'];
    image = json['image'];
  }
}
class ProductModel
{
  late int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  late String image;
  late String name;
  late bool inFavorites;
  late bool inCart;
  Map<String,dynamic>? json;
  ProductModel.fromJson(json)
  {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}