import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lottie/lottie.dart';
import 'model/product.dart';
import 'model/products_repository.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  List<Product> products = ProductsRepository.loadProducts(Category.all);

  List<Widget> _buildListCards(BuildContext context) {
    List<Product> featuredProducts = products.where((product) => product.isFeatured).toList();

    return featuredProducts.map((product) {
      return Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/detailPage',
              arguments: product,
            );
          },
          child: Stack(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 18 / 11,
                child: Image.asset(
                  product.assetName,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 150,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      product.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      maxLines: 1,
                    ),
                    Text(
                      product.location,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Container(
                width: 200, // 프로필 사진의 너비
                height: 200, // 프로필 사진의 높이
                child: Lottie.asset(
                  // 'assets/bear.json',
                  'assets/box.json',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text('Seok Won Kim'),
            Text('21900107'),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,30,150,0),
              child: Text('My Favorite Hotel List'),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: _buildListCards(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
