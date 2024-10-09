import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

        return ListView(
          children: snapshot.data!.docs.map((doc) {
            return Card(
              child: ListTile(
                leading: Image.network(doc['imageUrl'], width: 50, height: 50),
                title: Text('Tên sản phẩm: ${doc['name']}'),
                subtitle: Text('Giá: ${doc['price']}\nLoại: ${doc['category']}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(icon: Icon(Icons.edit), onPressed: () {}),
                    IconButton(icon: Icon(Icons.delete), onPressed: () {}),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}