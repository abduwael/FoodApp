class PopularFoodModel {

  late final int totalSize;
  late final int typeId;
  late final int offset;
  List<ProductsPopular> productsPopular=[];

  PopularFoodModel.fromJson(Map<String, dynamic> json){
    totalSize = json['total_size'];
    typeId = json['type_id'];
    offset = json['offset'];
    json['products'].forEach((e)
    {
      productsPopular.add(ProductsPopular.fromJson(e));
    });

  }

}

class ProductsPopular {
  ProductsPopular({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stars,
    required this.img,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
    required this.typeId,
  });
  int? id;
  String ?name;
  String? description;
  int? price;
  int ?stars;
  String? img;
  String ?location;
  String ?createdAt;
  String ?updatedAt;
  int ?typeId;

  ProductsPopular.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
  }

}