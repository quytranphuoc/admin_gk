import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../models/product.dart';
import '../services/product_service.dart';
import '../widgets/product_list.dart';
import 'package:admin_gk/services/auth_service.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _priceController = TextEditingController();
  File? _image;

  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> _addProduct() async {
    if (_nameController.text.isNotEmpty &&
        _categoryController.text.isNotEmpty &&
        _priceController.text.isNotEmpty &&
        _image != null) {
      await ProductService().addProduct(
        Product(
          name: _nameController.text,
          category: _categoryController.text,
          price: double.parse(_priceController.text),
          imageFile: _image!,
        ),
      );
    }
  }

  Future<void> _logout() async {
    await AuthService().signOut(); // Hàm logout từ AuthService
    Navigator.of(context)
        .pushReplacementNamed('/'); // Quay lại màn hình đăng nhập
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Dữ liệu sản phẩm',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30), // Có thể thêm style nếu cần
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout, // Gọi hàm logout khi nhấn nút
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        // child: Column(
        //   children: [
        //     TextField(
        //       controller: _nameController,
        //       decoration: InputDecoration(labelText: 'Tên sản phẩm'),
        //     ),
        //     TextField(
        //       controller: _categoryController,
        //       decoration: InputDecoration(labelText: 'Loại sản phẩm'),
        //     ),
        //     TextField(
        //       controller: _priceController,
        //       decoration: InputDecoration(labelText: 'Giá sản phẩm'),
        //       keyboardType: TextInputType.number,
        //     ),
        //     ElevatedButton.icon(
        //       onPressed: _pickImage,
        //       icon: Icon(Icons.folder),
        //       label: Text(_image != null
        //           ? _image!.path.split('/').last
        //           : 'Chọn hình ảnh'),
        //     ),
        //     ElevatedButton(
        //       onPressed: _addProduct,
        //       child: Text('Thêm sản phẩm'),
        //     ),
        //     SizedBox(height: 20),
        //     Expanded(
        //         child: ProductList()), // Widget hiển thị danh sách sản phẩm
        //   ],
        // ),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Tên sản phẩm',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color:
                          Colors.blue), // Viền màu xanh lá cây khi không focus
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0), // Viền màu xanh lá cây khi focus
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 10), // Khoảng cách giữa các TextField
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(
                labelText: 'Loại sản phẩm',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color:
                          Colors.blue), // Viền màu xanh lá cây khi không focus
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0), // Viền màu xanh lá cây khi focus
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 10), // Khoảng cách giữa các TextField
            TextField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: 'Giá sản phẩm',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color:
                          Colors.blue), // Viền màu xanh lá cây khi không focus
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0), // Viền màu xanh lá cây khi focus
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20), // Khoảng cách cho các nút
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: Icon(Icons.folder),
              label: Text(_image != null
                  ? _image!.path.split('/').last
                  : 'Chọn hình ảnh'),
            ),
            // ElevatedButton(
            //   onPressed: _addProduct,
            //   child: Text('Thêm sản phẩm'),
            // ),
            ElevatedButton(
              onPressed: _addProduct,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Đặt màu nền cho nút
                foregroundColor: Colors.white, // Đặt màu chữ trên nút
                minimumSize: Size(
                    double.infinity, 50), // Đặt chiều rộng full và chiều cao 50
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Bo viền của nút
                ),
              ),
              child: Text(
                'Thêm sản phẩm',
                style: TextStyle(fontSize: 16),
              ),
            ),

            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.blue, width: 2.0), // Add a bottom border
                ),
              ),
              child: Center(
                child: Text(
                  'Danh sách sản phẩm:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10), // Space before the product list
            Expanded(
              child: ProductList(), // Widget hiển thị danh sách sản phẩm
            ),
          ],
        ),
      ),
    );
  }
}
