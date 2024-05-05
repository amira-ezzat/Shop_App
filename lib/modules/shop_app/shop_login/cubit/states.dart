

import '../../../../model/shop_app/login_model.dart';

abstract class ShopLoginState{}

class ShopLoaginInitiat extends ShopLoginState{}

class ShopLoagLoading extends ShopLoginState{}

class ShopLoaginSuccess extends ShopLoginState{
  late final ShopLoginModel loginModel;
  ShopLoaginSuccess(this.loginModel);

}

class ShopLoaginError extends ShopLoginState{
  late final String error;
  ShopLoaginError(this.error);
}
class ShopChangePasswordVisibility extends ShopLoginState{}

