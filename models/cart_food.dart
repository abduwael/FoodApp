import 'package:food/models/recommeded_food.dart';
class CartModel {
  CartModel({
    required this.id,
    required this.name,
    required this.price,
    required this.img,
    required this.quantity,
    required this.isExist,
    required this.time,
    required this.product,
  });

  int? id;
  String? name;
  int? price;
  String? img;
  int? quantity;
  bool? isExist;
  String? time;
  ProductsModel?product;
  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 000000;
    name = json['name'] ?? '';
    price = json['price']??0;
    img = json['img']??'';
    quantity = json['quantity']??0;
    isExist = json['isExist']??true;
    time = json['time']??'';
    product=ProductsModel.fromJson(json['product']);
  }
  Map<String,dynamic>toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'img': img,
      'quantity':quantity,
      'isExist': isExist,
      'time': time,
      'product':product!.toJson(),

    };
  }

}
