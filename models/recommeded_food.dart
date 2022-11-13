class RecommendedFoodModel {
  RecommendedFoodModel({
    required this.totalSize,
    required this.typeId,
    required this.offset,
    required this.products,
  });
  late final int totalSize;
  late final int typeId;
  late final int offset;
   List<ProductsModel> products=[];

  RecommendedFoodModel.fromJson(Map<String, dynamic> json){
    totalSize = json['total_size'];
    typeId = json['type_id'];
    offset = json['offset'];
    json['products'].forEach((e)
    {
      products.add(ProductsModel.fromJson(e));
    });

  }

}

class ProductsModel {
  ProductsModel({
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

  ProductsModel.fromJson(Map<String, dynamic> json){
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

  Map<String, dynamic> toJson() {
   return {
   'id': id,
   'name' : name,
   'description' : description,
   'price' : price,
   'stars' : stars,
   'img' : img,
   'location' : location,
   'created_at' : createdAt,
   'updated_at' : updatedAt,
   'type_id' : typeId,
  };
  }

}