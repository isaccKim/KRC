import 'package:flutter/material.dart';
import 'model/product.dart';
import 'model/products_repository.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

List<Widget> _buildStarIcons(int starCount) {
  List<Widget> stars = [];
  for (int i = 0; i < starCount; i++) {
    stars.add(Icon(Icons.star, color: Colors.yellow));
  }
  return stars;
}
class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _isFavorited = false;



  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context)!.settings.arguments as Product;
    _isFavorited = product.isFeatured;
    void _toggleFavorite() {
      setState(() {
        if (_isFavorited) {
          _isFavorited = false;
          ProductsRepository.updateProductFeaturedStatus(product.id, false);
        } else {
          _isFavorited = true;
          ProductsRepository.updateProductFeaturedStatus(product.id, true);

        }
      });
    }
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: _buildStarIcons(product.star), // product.star 값 만큼 별 아이콘 생성
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      product.name,
                      textStyle: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                      speed: const Duration(milliseconds: 2000),
                    ),
                  ],

                  totalRepeatCount: 4,
                  pause: const Duration(milliseconds: 1000),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Icon(Icons.location_on),
                      Text(
                        product.location,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.phone),
                    Text(
                      product.call,
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;

    Widget textSection = Container(
      padding: const EdgeInsets.all(32.0),

      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                product.info,
                maxLines: 5, // 최대 5줄까지 표시하고 싶다면 이 숫자를 조절하세요.
                style: TextStyle(fontSize: 15),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ]
      ),
    );

    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Detail'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(); // 뒤로 가기 기능 추가
            },
          ),
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                InkWell(
                  onDoubleTap: () {
                    _toggleFavorite();
                  },
                  child: Hero(
                    tag: 'moreButton_${product.id}',
                    child: Image.asset(
                      product.assetName,
                      width: 600,
                      height: 240,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                titleSection,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Divider(
                    height: 3,
                    color: Colors.blue,
                  ),
                ),
                textSection,
              ],
            ),
            Overlay(
              initialEntries: [
                OverlayEntry(
                  builder: (context) => Positioned(
                    top: 20,
                    right: 20,
                    child: Icon(
                      _isFavorited
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon,
          color: color,),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

