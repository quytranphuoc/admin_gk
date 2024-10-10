import 'package:admin_gk/models/product.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin_gk/services/product_service.dart';

class ProductList extends StatelessWidget {
  //chu ý thay đoior
  final ProductService _productService = ProductService();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        return ListView(
          children: snapshot.data!.docs.map((doc) {
            return Card(
              child: Column(
                children: [
                  ListTile(
                    leading:
                        Image.network(doc['imageUrl'], width: 50, height: 50),
                    title: Text('Tên sản phẩm: ${doc['name']}'),
                    subtitle:
                        Text('Giá: ${doc['price']}\nLoại: ${doc['category']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _editProduct(context, doc); // Gọi hàm edit
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            await ProductService()
                                .deleteProduct(doc.id); // Sửa cú pháp
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

void _editProduct(BuildContext context, DocumentSnapshot doc) {
  TextEditingController nameController =
      TextEditingController(text: doc['name']);
  TextEditingController categoryController =
      TextEditingController(text: doc['category']);
  TextEditingController priceController =
      TextEditingController(text: doc['price'].toString());

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Cập nhật sản phẩm'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Tên sản phẩm'),
            ),
            TextField(
              controller: categoryController,
              decoration: InputDecoration(labelText: 'Loại sản phẩm'),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Giá sản phẩm'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Đóng hộp thoại
            },
            child: Text('Hủy'),
          ),
          TextButton(
            onPressed: () async {
              String updatedName = nameController.text;
              String updatedCategory = categoryController.text;
              double updatedPrice = double.tryParse(priceController.text) ?? 0;

              // Gọi hàm cập nhật sản phẩm
              await ProductService().updateProductInfo(
                  doc.id, updatedName, updatedCategory, updatedPrice);
              Navigator.of(context).pop(); // Đóng hộp thoại sau khi cập nhật
            },
            child: Text('Cập nhật'),
          ),
        ],
      );
    },
  );
}
