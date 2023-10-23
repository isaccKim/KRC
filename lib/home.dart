// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'detail.dart';
import 'model/product.dart';
import 'model/products_repository.dart';

const List<Widget> icons = <Widget>[
  Icon(Icons.list),
  Icon(Icons.grid_view),
];

List<Widget> _buildStarIcons(int starCount) {
  List<Widget> stars = [];
  for (int i = 0; i < starCount; i++) {
    stars.add(Icon(Icons.star, color: Colors.yellow, size: 10));
  }
  return stars;
}

_launchURL() async {
  const url = 'https://www.handong.edu/'; // Specify your URL here
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  bool _isListView = false; // Variable to track the current view mode
  final List<bool> _selectedView = <bool>[false, true]; // Default: list view

  void _toggleView() {
    setState(() {
      _isListView = !_isListView; // Toggle the view mode
    });
  }

  List<Card> _buildGridCards(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);

    if (products.isEmpty) {
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());

    return products.map((product) {
      return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18 / 11,
              child: Image.asset(
                product.assetName,
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(width: 4,),
                  Icon(Icons.place,color: Colors.blue,size: 16,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(3, 20, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: _buildStarIcons(product.star), // product.star 값 만큼 별 아이콘 생성
                        ),
                        Text(
                          product.name,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 8),
                          // maxLines: 1,
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          product.location,
                          maxLines: 2, // 최대 2줄까지 표시
                          style: TextStyle(fontSize: 6),
                          overflow: TextOverflow.ellipsis, // 넘어가는 경우 ...으로 표시
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 3),
                    child: Hero(
                      tag: 'moreButton_${product.id}', // 다른 Hero와 중복되지 않는 고유한 태그 부여
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,'/detailPage',
                              arguments: product,
                            );
                          },
                          child: Text(
                            'more',
                            style: TextStyle(color: Colors.blue,fontSize: 10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList();
  }


  List<Widget> _buildListCards(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);

    return products.map((product) {
      return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            ListTile(
              leading: AspectRatio(
                aspectRatio: 18 / 11,
                child:
                Image.asset(
                  product.assetName,
                  fit: BoxFit.fitWidth,
                ),
              ),
              title: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: _buildStarIcons(product.star),
                    ),
                    Text(
                      product.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              subtitle: Text(
                product.location,
                maxLines: 2,
                style: TextStyle(fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/detailPage',
                        arguments: product, // 제품 객체를 인자로 전달합니다.
                      );
                    },
                    child: Hero(
                      tag: 'moreButton_${product.id}', // 다른 Hero와 중복되지 않는 고유한 태그 부여
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,'/detailPage',
                              arguments: product
                            );
                          },
                          child: Text(
                            'more',
                            style: TextStyle(color: Colors.blue,fontSize: 10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }).toList();
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Main'),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.search,
                semanticLabel: 'search',
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/searchPage');
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.language,
                semanticLabel: 'filter',
              ),
              onPressed: () {
                _launchURL();
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: ToggleButtons(
                    direction: Axis.horizontal,
                    onPressed: (int index) {
                      setState(() {
                        for (int i = 0; i < _selectedView.length; i++) {
                          _selectedView[i] = i == index;
                        }
                        _isListView = index == 0; // 0: list view, 1: grid view
                      });
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(2)),
                    selectedBorderColor: Colors.blue[700],
                    selectedColor: Colors.white,
                    fillColor: Colors.blue[200],
                    color: Colors.blue[400],
                    isSelected: _selectedView,
                    children: icons,
                  ),
                ),
              ],
            ),
            Expanded(
              child: _isListView
                  ? ListView(
                padding: const EdgeInsets.all(16.0),
                children: _buildListCards(context),
              )
                  :OrientationBuilder(
                builder: (context, orientation) {
                  return GridView.count(
                    crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
                    padding: const EdgeInsets.all(16.0),
                    childAspectRatio: 8.0 / 9.0,
                    children: _buildGridCards(context),
                  );
                },
              ),
              // GridView.count(
              //   crossAxisCount: 2,
              //   padding: const EdgeInsets.all(16.0),
              //   childAspectRatio: 8.0 / 9.0,
              //   children: _buildGridCards(context),
              // ),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Pages'),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context,'/homePage');
                },
              ),
              ListTile(
                leading: Icon(Icons.search),
                title: const Text('Search'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context,'/searchPage');
                },
              ),
              ListTile(
                leading: Icon(Icons.location_city),
                title: const Text('Favorite Hotel'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context,'/favoritePage');

                },
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: const Text('My Page'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context,'/myPage');
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: const Text('Log Out'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ],
          ),
        ),
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}
