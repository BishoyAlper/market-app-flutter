import 'package:additemapp/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailedProduct extends StatelessWidget{
  final String id;
  const DetailedProduct(this.id);

  @override
  Widget build(BuildContext context) {
    List<Product> prodList = Provider.of<Products>(context, listen: true).productsList;
    var filterItem = prodList.firstWhere((item) => item.id == id, orElse: ()=> null);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: filterItem == null ? null : Text(filterItem.title),
      ),
      body: filterItem == null ? null
          : ListView(
        children: [
          SizedBox(height: 10),
          buildContainer(filterItem.imageUrl, filterItem.id),
          SizedBox(height: 10),
          buildCard(filterItem.title, filterItem.description, filterItem.price),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          Navigator.pop(context, filterItem.id);
        },
        child: Icon(Icons.delete, color: Colors.black),
      ),
    );
  }

  Container buildContainer(String image, String id){
    return Container(
      width: double.infinity,
      child: Center(
        child: Hero(
          tag: id,
          child: Image.network(image),
        ),
      ),
    );
  }

  Card buildCard(String title, String description, double price){
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(7),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Divider(color: Colors.black),
            Text(
                description,
                style: TextStyle(fontSize: 16), textAlign: TextAlign.justify),
            Divider(color: Colors.black),
            Text(
              "\$$price",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
            ),
          ],
        ),
      ),
    );
  }
}