import 'package:additemapp/addproduct.dart';
import 'package:additemapp/product_detailed.dart';
import 'package:additemapp/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider<Products>(
      create: (_) => Products(),
      child: MyApp(),
  ),
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.orange,
          canvasColor: Color.fromRGBO(255, 238, 219, 1)),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    List<Product> prodList = Provider.of<Products>(context).productsList;

    Widget detailCards(String id,String title, String desc, double price, String iamgeURL, BuildContext ctx){
      return FlatButton(
        onPressed: (){
            Navigator.push(ctx, MaterialPageRoute(builder: (_) => DetailedProduct(id))
            ).then((id) => Provider.of<Products>(context, listen: false).delete(id));
        },
        child: Column(
          children: [
            SizedBox(height: 5),
            Card(
              elevation: 10,
              color: Color.fromRGBO(115, 138, 119, 1),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.only(right: 10),
                      width: 130,
                      child: Hero(
                        tag: id,
                        child: Image.network(iamgeURL),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(title, style: TextStyle(
                            fontWeight:
                            FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white)),
                        Divider(color: Colors.white),
                        Container(
                          width: 200,
                          child: Text(
                            desc,
                            style: TextStyle(color: Colors.white, fontSize: 14),
                            softWrap: true,
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.justify,
                            maxLines: 3,
                          ),
                        ),
                        Divider(color: Colors.white),
                        Text(
                          "\$$price",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        SizedBox(height: 13),
                      ],
                    ),
                  ),
                  Expanded(flex: 1, child: Icon(Icons.arrow_forward_ios)),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("add product"),
      ),
      body: prodList.isEmpty? Center(child: Text("No Prodects added", style: TextStyle(fontSize: 22))) 
      : ListView(
        children: prodList
            .map(
                (item) => Builder(
                    builder: (ctx) => detailCards(item.id, item.title, item.description, item.price, item.imageUrl, ctx)),
        ).toList(),
      ),

      floatingActionButton: Container(
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.orange,
        ),
        child:
            FlatButton.icon(
              label: Text("Add Product", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              icon: Icon(Icons.add),
              onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (ctx)=> AddProduct())),
        ),
      ),
    );
  }
}
