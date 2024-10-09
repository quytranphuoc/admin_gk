import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/product.dart';
import 'dart:io';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> addProduct(Product product) async {
    String imageUrl = await _uploadImage(product.imageFile);
    await _firestore.collection('products').add({
      'name': product.name,
      'category': product.category,
      'price': product.price,
      'imageUrl': imageUrl,
    });
  }

  Future<void> deleteProduct(String productId) async {
    await _firestore.collection('products').doc(productId).delete();
  }

  Future<void> updateProduct(Product product) async {
    await _firestore.collection('products').doc(product.id).update({
      'name': product.name,
      'category': product.category,
      'price': product.price,
      'imageUrl': product.imageUrl,
    });
  }

  Future<String> _uploadImage(File imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageRef = _storage.ref().child('images/$fileName');
    await storageRef.putFile(imageFile);
    return await storageRef.getDownloadURL();
  }
}