import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/cubit/shop_Cubit/shop_states.dart';
import 'package:shopapp/models/categories_model.dart';
import 'package:shopapp/models/change_favorites_model.dart';
import 'package:shopapp/models/favorites_model.dart';
import 'package:shopapp/models/home_model.dart';
import 'package:shopapp/models/login_model.dart';
import 'package:shopapp/module/categories_screen.dart';
import 'package:shopapp/module/favourites_screen.dart';
import 'package:shopapp/module/products_screen.dart';
import 'package:shopapp/module/setting_screen.dart';
import 'package:shopapp/shared/constant.dart';
import 'package:shopapp/shared/network/dio_helper.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentState = 0;

  List<Widget> bottomScreen = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingScreen(),
  ];

  void ChangeBottom(int index) {
    currentState = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  Map<int , bool> favorites = {};
  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: 'home',
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel?.data.banners[0].image);
      print(homeModel.toString());
      homeModel!.data.products.forEach((element) {
        favorites.addAll(
          {
            element.id : element.inFavorites,
          }
        );
      });
      print(favorites);
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategories() {

    DioHelper.getData(
      url: 'categories',
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId)
  {
    favorites[productId] =!favorites[productId]!;
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
        url: 'favorites',
        data: {
          'product_id': productId,
        },
        token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if(!changeFavoritesModel!.status){
        favorites[productId] =!favorites[productId]!;

      }else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error){
      favorites[productId] =!favorites[productId]!;

      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites() {

    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: 'favorites',
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }


  ShopLoginModel? userModel;
  void getUserData() {

    //emit(ShopLoadingGetUserDataState());
    DioHelper.getData(
      url: 'profile',
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);

      emit(ShopSuccessGetUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetUserDataState());
    });
  }
  void updateUserData({
    required String name,
    required String email,
    required String phone,
}) {

    DioHelper.putData(
      url: 'update-profile',
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      },
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);

      emit(ShopSuccessUpdateState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateState());
    });
  }

}
