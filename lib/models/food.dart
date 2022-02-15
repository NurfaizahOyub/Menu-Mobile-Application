import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  String id;
  String name;
  String price;
  String image;
  List subIngredients = [];
  Timestamp createdAt;
  Timestamp updatedAt;

  Food();

  Food.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    price = data['price'];
    image = data['image'];
    subIngredients = data['subIngredients'];
    createdAt = data['createdAt'];
    updatedAt = data['updatedAt'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'subIngredients': subIngredients,
      'createdAt': createdAt,
      'updatedAt': updatedAt
    };
  }
}
