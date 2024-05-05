
import 'package:bloc/bloc.dart';
import 'package:chats_app/layout/shop_app/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/shop_app/addFavorite_model.dart';
import '../../../model/shop_app/categories_model.dart';
import '../../../model/shop_app/favorite_model.dart';
import '../../../model/shop_app/home_model.dart';
import '../../../model/shop_app/login_model.dart';
import '../../../modules/shop_app/cateogries/cateogries.dart';
import '../../../modules/shop_app/favorite/favorite.dart';
import '../../../modules/shop_app/products/products.dart';
import '../../../modules/shop_app/setteing/setteing.dart';
import '../../../shared/compononse/constants.dart';
import '../../../shared/network/end_point.dart';
import '../../../shared/network/remote/dio_helpeer.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit():super (ShopInitiateStates());
  static ShopCubit get(context)=>BlocProvider.of(context);
  int currentIndex=0;
  List<Widget>bottomScreen=[
    ProductsScreen(),
    CateogriesScreen(),
    FavoriteScreen(),
    SetteingScreen(),
  ];

  void changeBottom(int index)
  {
    currentIndex = index ;
    emit(ShopChangeBottomStates());
  }
  HomeModel? homeModel;
  Map<int ,bool>favorites={};
  void getHomeData() {
    emit(ShopLoadingHomeDataStates());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      printFullText(homeModel!.data.banners[0].image);
      print(homeModel!.status);
      homeModel?.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });
      emit(ShopSuccessHomeDataStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataStates());
    });
  }


  CategoriesModel? categoriesModel;
  void getCategoriesData()
  {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {

      categoriesModel=CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesDataStates());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesDataStates());
    });
  }
  ChangeFavoriteModel? changeFavoriteModel;
  void changeFavorite(int productId)
  {
    favorites[productId] = !(favorites[productId] ?? false);
    emit(ShopChangeFavoriteStates());
    DioHelper.postData(
        url: FAVORITES,
        data:{
          'product_id':productId
        },
      token: token,
    ).then((value){
      changeFavoriteModel=ChangeFavoriteModel.fromJson(value.data);
       print(value.data);
      if(!changeFavoriteModel!.status)
        {
          favorites[productId] = !(favorites[productId] ?? false);
        }
      else
        {
          getFavorites();
        }

      emit(ShopSuccessChangeFavoriteStates(changeFavoriteModel!));
    })
        .catchError((error){
      favorites[productId] = !(favorites[productId] ?? false);
          emit(ShopErrorChangeFavoriteStates());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites()
  {
    emit(ShopLoadingGetFavoritesStates());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {

      favoritesModel=FavoritesModel.fromJson(value.data);
      printFullText(value.data.toString());
      emit(ShopSuccessGetFavoritesStates());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetFavoritesStates());
    });
  }

  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingUserModelStates());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.FormJson(value.data);
      printFullText(userModel!.data.name);
      emit(ShopSuccessUserModelStates(userModel!));
    }).catchError((error) {
      print('Error fetching user data: $error');

      // You can also print the stack trace for more details
      // print(error.stackTrace);

      emit(ShopErrorUserModelStates());
    });
  }

  void updateUserData({
  required String name,
  required String email,
  required String phone,
}) {
    emit(ShopLoadingUpdateUserlStates());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      },
    ).then((value) {
      userModel = ShopLoginModel.FormJson(value.data);
      printFullText(userModel!.data.name);
      emit(ShopSuccessUpdateUserStates(userModel!));
    }).catchError((error) {
      print('Error fetching user data: $error');


      emit(ShopErrorUpdateUserStates());
    });
  }

}
