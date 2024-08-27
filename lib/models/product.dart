import 'dart:convert';

class Product {
  final String name;
  final String description;
  final double quantity;
  final List<String> images;
  final String category;
  final double price;
  final String? id;
  // final List<Rating>? rating;
  Product({
    required this.name,
    required this.description,
    required this.quantity,
    required this.images,
    required this.category,
    required this.price,
    this.id,
    // this.rating,
  });

//inputs taken from the admin (During adding a product) are in object format
//using this toMap function we will convert them to Map format (useful for converting the product to a format that can be easily serialized to JSON.)
//from this Map datatype we can easily convert to json format then send to the server...
//SO This method converts a Product object to a Map<String, dynamic>.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      'id': id,
      // 'rating': rating,
    };
  }

//Data came from the server are in json format ,
//we first convert json to Map then to Object
//here we are converting Map Datatype to Object type to use in our app
//SO This factory constructor creates a Product object from a Map<String, dynamic>.
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity']?.toDouble() ?? 0.0,
      images: List<String>.from(map['images']),
      category: map['category'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      id: map['_id'],
      // rating: map['ratings'] != null
      //     ? List<Rating>.from(
      //         map['ratings']?.map(
      //           (x) => Rating.fromMap(x),
      //         ),
      //       )
      //     : null,
    );
  }

//toJson -> This method converts the 'Product' object to a JSON string.
//It uses the toMap method to first convert the object to a map,
//and then uses json.encode to convert that map to a JSON string.
  String toJson() => json.encode(toMap());

//fromJson This factory constructor creates a Product object from a JSON string.
//It uses json.decode to first convert the JSON string to a map,
//and then fromMap to convert that map to a Product object.
  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
