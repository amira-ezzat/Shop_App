

class ShopLoginModel {

  late bool status;
  late String message;
  late UserData data;

  ShopLoginModel.FormJson(Map<String,dynamic>json)
  {
    status = json['status'];
    message = json['message'];
    data = (json['data'] !=null ? UserData.FormJson(json['data']):null)!;
  }


}
class UserData{
  late int id;
  late String email;
  late String name;
  late String phone;
  late String image;
  late int points;
  late int credit;
  late String token;
// UserData({
//   required this.id,
//   required this.email,
//   required this.name,
//   required this.phone,
//   required this.image,
//   required this.points,
//   required this.credit,
//   required this.token,
// });
UserData.FormJson(Map<String,dynamic>json)
{
  id=json['id'];
  email=json['email'];
  name=json['name'];
  phone=json['phone'];
  image=json['image'];
  points=json['points'];
  credit=json['credit'];
  token=json['token'];


}
}