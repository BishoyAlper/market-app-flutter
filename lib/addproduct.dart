import 'dart:io';
import 'package:additemapp/main.dart';
import 'package:additemapp/products.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class AddProduct extends StatefulWidget{
  @override
  _AddProductState createState() => _AddProductState();
  }

class _AddProductState extends State<AddProduct> {
  var titleController = TextEditingController();
  var descController = TextEditingController();
  var priceController = TextEditingController();
  var imageURLCont = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Add product"),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              TextField(
                decoration: InputDecoration(
                    labelText: "title",
                    hintText: "Add title"
                ),
                controller: titleController,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: "description",
                    hintText: "Add description"
                ),
                controller: descController,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: "price",
                    hintText: "Add price"
                ),
                controller: priceController,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: "image URL",
                  hintText: "paste ur image url here"
                ),
                controller: imageURLCont,
              ),
              SizedBox(height: 30),
              Consumer<Products>(
                builder: (ctx, val, _) => RaisedButton(
                  color: Colors.orangeAccent,
                  textColor: Colors.black,
                  child: Text("Add product"),
                  onPressed: () async{
                    if(titleController.text.isEmpty || descController.text.isEmpty || priceController.text.isEmpty || imageURLCont.text.isEmpty){
                      Toast.show("please enter all fields", ctx, duration: Toast.LENGTH_LONG);
                    }
                    else{
                      try{
                        val.add(
                          id: DateTime.now().toString(),
                          title: titleController.text,
                          description: descController.text,
                          price: double.parse(priceController.text),
                          imageUrl: imageURLCont.text,
                        );
                        await Navigator.pop(context);
                      }catch (e){
                          Toast.show("please entervalid price", ctx, duration: Toast.LENGTH_LONG);
                          print(e);
                      }
                    }
                  },
                )
              )
            ],
          ),
        ),
    );
  }
}
