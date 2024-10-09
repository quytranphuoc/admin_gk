import 'dart:io';

class Product {
  String? id;
  final String name;
  final String category;
  final double price;
  final File imageFile;
  String? imageUrl;
  // final String? imageUrl;
  // final File? imageFile;

  Product({
    this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.imageFile,
    this.imageUrl,
  });
}
