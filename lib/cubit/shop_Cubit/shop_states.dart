import 'package:shopapp/models/change_favorites_model.dart';
import 'package:shopapp/models/login_model.dart';

class ShopState {}
class ShopInitialState extends ShopState{}
class ShopChangeBottomNavState extends ShopState{}
class ShopLoadingHomeDataState extends ShopState{}
class ShopSuccessHomeDataState extends ShopState{}
class ShopErrorHomeDataState extends ShopState{}
class ShopSuccessCategoriesState extends ShopState{}
class ShopErrorCategoriesState extends ShopState{}
class ShopChangeFavoritesState extends ShopState{}
class ShopSuccessChangeFavoritesState extends ShopState{
   final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}
class ShopErrorChangeFavoritesState extends ShopState{}

class ShopLoadingGetFavoritesState extends ShopState{}
class ShopSuccessGetFavoritesState extends ShopState{}
class ShopErrorGetFavoritesState extends ShopState{}
class ShopLoadingGetUserDataState extends ShopState{}
class ShopSuccessGetUserDataState extends ShopState{
  final ShopLoginModel loginModel;

  ShopSuccessGetUserDataState(this.loginModel);
}
class ShopErrorGetUserDataState extends ShopState{}

class ShopLoadingUpdateState extends ShopState{}
class ShopSuccessUpdateState extends ShopState{
  final ShopLoginModel loginModel;

  ShopSuccessUpdateState(this.loginModel);
}
class ShopErrorUpdateState extends ShopState{}