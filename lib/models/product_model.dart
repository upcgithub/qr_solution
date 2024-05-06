import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class ProductModel {
  int? id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final double lat;
  final double lng;

  ProductModel({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.lat,
    required this.lng,
  });

  getLatLng() {
    return LatLng(lat, lng);
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        imageUrl: json["imageUrl"],
        lat: json["lat"],
        lng: json["lng"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "imageUrl": imageUrl,
        "lat": lat,
        "lng": lng,
      };
}
