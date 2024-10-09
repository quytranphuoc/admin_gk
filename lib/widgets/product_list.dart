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
                  AppBar(
                    title: Center(
                      child: Text(
                        'Danh sách sản phẩm:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20), // Có thể thêm style nếu cần
                      ),
                    ),
                  ),
                  ListTile(
                    leading:
                        Image.network(doc['imageUrl'], width: 50, height: 50),
                    title: Text('Tên sản phẩm: ${doc['name']}'),
                    subtitle:
                        Text('Giá: ${doc['price']}\nLoại: ${doc['category']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // IconButton(
                        //   icon: Icon(Icons.edit),
                        //   onPressed: () {
                        //     _editProduct(context, doc); // Gọi hàm edit
                        //   },
                        // ),
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

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:admin_gk/services/product_service.dart'; // Import ProductService để dùng hàm update và delete
// import 'package:admin_gk/models/product.dart';
// class ProductList extends StatelessWidget {
//   final ProductService _productService = ProductService();

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseFirestore.instance.collection('products').snapshots(),
//       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (!snapshot.hasData)
//           return Center(child: CircularProgressIndicator());

//         return ListView(
//           children: snapshot.data!.docs.map((doc) {
//             return Card(
//               child: ListTile(
//                 leading: Image.network(doc['imageUrl'], width: 50, height: 50),
//                 title: Text('Tên sản phẩm: ${doc['name']}'),
//                 subtitle:
//                     Text('Giá: ${doc['price']}\nLoại: ${doc['category']}'),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.edit),
//                       onPressed: () {
//                         _editProduct(context, doc); // Gọi hàm edit
//                       },
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.delete),
//                       onPressed: () {
//                         _productService
//                             .deleteProduct(doc.id); // Truyền productId để xóa
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),
//         );
//       },
//     );
//   }

//   void _editProduct(BuildContext context, DocumentSnapshot doc) {
//     // Hàm này mở màn hình hoặc dialog cho phép chỉnh sửa sản phẩm
//     // Bạn có thể tạo một màn hình riêng để cập nhật sản phẩm
//     showDialog(
//       context: context,
//       builder: (context) {
//         TextEditingController nameController =
//             TextEditingController(text: doc['name']);
//         TextEditingController categoryController =
//             TextEditingController(text: doc['category']);
//         TextEditingController priceController =
//             TextEditingController(text: doc['price'].toString());

//         return AlertDialog(
//           title: Text('Chỉnh sửa sản phẩm'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                   controller: nameController,
//                   decoration: InputDecoration(labelText: 'Tên sản phẩm')),
//               TextField(
//                   controller: categoryController,
//                   decoration: InputDecoration(labelText: 'Loại sản phẩm')),
//               TextField(
//                   controller: priceController,
//                   decoration: InputDecoration(labelText: 'Giá sản phẩm')),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () async {
//                 // Cập nhật sản phẩm
//                 await _productService.updateProduct(Product(
//                   id: doc.id,
//                   name: nameController.text,
//                   category: categoryController.text,
//                   price: priceController.text,
//                   imageUrl: doc['imageUrl'], // Giữ nguyên URL ảnh
//                 ));
//                 Navigator.pop(context);
//               },
//               child: Text('Lưu'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Hủy'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
