

import '../../../model/shop_app/addFavorite_model.dart';
import '../../../model/shop_app/login_model.dart';

abstract class ShopStates {}

class ShopInitiateStates extends ShopStates{}

class ShopChangeBottomStates extends ShopStates{}

class ShopLoadingHomeDataStates extends ShopStates{}

class ShopSuccessHomeDataStates extends ShopStates{}

class ShopErrorHomeDataStates extends ShopStates{}

class ShopSuccessCategoriesDataStates extends ShopStates{}

class ShopErrorCategoriesDataStates extends ShopStates{}

class ShopSuccessChangeFavoriteStates extends ShopStates{
  final ChangeFavoriteModel model;
  ShopSuccessChangeFavoriteStates(this.model);
}

class ShopChangeFavoriteStates extends ShopStates{}

class ShopErrorChangeFavoriteStates extends ShopStates{}

class ShopLoadingGetFavoritesStates extends ShopStates{}

class ShopSuccessGetFavoritesStates extends ShopStates{}

class ShopErrorGetFavoritesStates extends ShopStates{}

class ShopLoadingUserModelStates extends ShopStates{}

class ShopSuccessUserModelStates extends ShopStates{
  late ShopLoginModel loginModel;
  ShopSuccessUserModelStates(this.loginModel);
}

class ShopErrorUserModelStates extends ShopStates{}

class ShopLoadingUpdateUserlStates extends ShopStates{}

class ShopSuccessUpdateUserStates extends ShopStates{
  late ShopLoginModel loginModel;
  ShopSuccessUpdateUserStates(this.loginModel);
}

class ShopErrorUpdateUserStates extends ShopStates{}




// class ShopLoadingHomeDataStates extends ShopStates{}