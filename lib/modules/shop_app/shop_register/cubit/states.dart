
import '../../../../model/shop_app/login_model.dart';

abstract class ShopRegisterState{}


class ShopRegisterInitiat extends ShopRegisterState{}

class ShopRegisterLoading extends ShopRegisterState{}
class ShopRegisterSuccess extends ShopRegisterState{
  late final ShopLoginModel loginModel;
  ShopRegisterSuccess(this.loginModel) {

  }

}

class ShopRegisterError extends ShopRegisterState{
  late final String error;
  ShopRegisterError(this.error);
}
class ShopRegisterChangePasswordVisibility extends ShopRegisterState{}

