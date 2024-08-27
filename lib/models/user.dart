import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String address;
  final String type;
  final String token;
  //final List<dynamic> cart;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.type,
    required this.token,
    //required this.cart,
  });

  //toMap(): Converts a User instance to a map, useful for serialization.
  //Return Type: Map<String, dynamic>, where the keys are strings representing the field names and the values are the corresponding field values from the User object.
  //from the map we can convert it to JSON then sending the data to the backend.
  // User object -> Map -> Json -> send to the server
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'type': type,
      'token': token,
      //'cart': cart,
    };
  }

//The fromMap factory constructor creates a User instance or object from a Map<String, dynamic> comming from backend
//This is useful for deserialization, such as when you receive data from a backend service.
//Uses the values from the map to populate the fields of the User object.
// from backend -> Json -> Map -> User object
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '', //because from the backend it is comming as _id
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
      // cart: List<Map<String, dynamic>>.from(
      //   map['cart']?.map(
      //     (x) => Map<String, dynamic>.from(x),
      //   ),
      // ),
    );
  }

//This method converts the User instance to a JSON string.
//It first converts the instance to a map using toMap, then encodes it to a JSON string using json.encode.
  String toJson() => json.encode(toMap());

//This factory constructor creates a User instance from a JSON string.
//It decodes the JSON string to a map using json.decode and then uses fromMap to create the User instance.
//json -> map using json.decode() then map -> User instance using fromMap()
  factory User.fromJson(String source) => User.fromMap(json.decode(source));

//The copyWith() method creates a new User instance where you can optionally change some of the properties.It takes optional named parameters for each property of the User class.
//For each property, if the corresponding parameter is provided (!= null), the new instance will use the new value.
//If the parameter is not provided (== null), the new instance will use the existing value from the current object (this).
//It helps maintain immutability by creating new instances rather than modifying existing ones.
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? address,
    String? type,
    String? token,
    //List<dynamic>? cart,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      type: type ?? this.type,
      token: token ?? this.token,
      // cart: cart ?? this.cart,
    );
  }
}
