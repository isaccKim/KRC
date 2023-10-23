import 'package:flutter/material.dart';
import 'model/product.dart';
import 'model/products_repository.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Product> products = ProductsRepository.loadProducts(Category.all);
  @override
  Widget build(BuildContext context) {
    const title = 'Favorite Hotels';

    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Search'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(); // 뒤로 가기 기능 추가
            },
          ),
        ),
        body: ListView.builder(
          itemCount: products.where((product) => product.isFeatured).length,
          itemBuilder: (context, index) {
            final featuredProducts =
            products.where((product) => product.isFeatured).toList();
            final item = featuredProducts[index];
            return Dismissible(
              key: Key(item.name),
              onDismissed: (direction) {
                setState(() {
                  // Update the isFeatured property to false
                  item.isFeatured = false;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${item.name} dismissed')),
                );
              },
              background: Container(color: Colors.red),
              child: ListTile(
                title: Text(item.name),
              ),
            );
          },
        ),
      ),
    );
  }
}
