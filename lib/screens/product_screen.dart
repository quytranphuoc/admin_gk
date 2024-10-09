import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../models/product.dart';
import '../services/product_service.dart';
import '../widgets/product_list.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sản phẩm')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Tên sản phẩm'),
            ),
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(labelText: 'Loại sản phẩm'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Giá sản phẩm'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: Icon(Icons.folder),
              label: Text(_image != null
                  ? _image!.path.split('/').last
                  : 'Chọn hình ảnh'),
            ),
            ElevatedButton(
              onPressed: _addProduct,
              child: Text('Thêm sản phẩm'),
            ),
            SizedBox(height: 20),
            Expanded(child: ProductList()), // Widget hiển thị danh sách sản phẩm
          ],
        ),
      ),
    );
  }
}

