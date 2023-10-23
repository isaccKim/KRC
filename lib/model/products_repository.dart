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

import 'package:flutter/cupertino.dart';

import 'product.dart';

class ProductsRepository {
  static List<Product> allProducts = [
    Product(
        category: Category.accessories,
        id: 0,
        isFeatured: false,
        name: 'PP Hotel',
        star: 3,
        location: 'London',
        call: '+22 010 123 432 11',
        info: ' What are you going to do? I will read a book. What are you going to do? I will read a book.'
    ),
    Product(
        category: Category.accessories,

        id: 1,
        isFeatured: false,
        name: 'OJ Hotel',
        star: 3,
        location: 'Paris',
        call: '+82 010 123 432 11',
        info: ' What are you going to do? I will read a book. What are you going to do? I will read a book.'
    ),
    Product(
        category: Category.accessories,
        id: 2,
        isFeatured: false,
        name: 'SS Hotel',
        star: 4,
        location: 'Korea',
        call: '+23 010 123 432 11',
        info: ' What are you going to do? I will read a book. What are you going to do? I will read a book.'
    ),
    Product(
        category: Category.accessories,
        id: 3,
        isFeatured: false,
        name: 'GG Hotel',
        star: 4,
        location: 'Jeju',
        call: '+82 010 123 432 11',
        info: ' What are you going to do? I will read a book. What are you going to do? I will read a book.'
    ),
    Product(
        category: Category.accessories,
        id: 4,
        isFeatured: false,
        name: 'NM Hotel',
        star: 4,
        location: 'Japan',
        call: '+222 010 123 432 11', info: ' What are you going to do? I will read a book. What are you going to do? I will read a book.'
    ),
    Product(
        category: Category.accessories,
        id: 5,
        isFeatured: false,
        name: 'TR hotel',
        star: 4,
        location: 'LA',
        call: '+887 010 123 432 11',
        info: ' What are you going to do? I will read a book. What are you going to do? I will read a book.'
    ),
  ];

  static void updateProductFeaturedStatus(int productId, bool isFeatured) {
    Product productToUpdate = allProducts.firstWhere((product) => product.id == productId);
    productToUpdate.isFeatured = isFeatured;

  }

  static List<Product> loadProducts(Category category) {
    if (category == Category.all) {
      return allProducts;
    } else {
      return allProducts.where((Product p) {
        return p.category == category;
      }).toList();
    }
  }
}
