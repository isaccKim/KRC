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

enum Category {
  all,
  accessories,
  clothing,
  home,
}

class Product {
  Product({
    required this.category,
    required this.id,
    required this.isFeatured,
    required this.name,
    required this.star,
    required this.location,
    required this.call,
    required this.info,
  });

  final Category category;
  final int id;
  bool isFeatured;
  final String name;
  final int star;
  final String location;
  final String call;
  final String info;

  String get assetName => 'assets/$id-0.jpg';

  @override
  String toString() => "$name (id=$id)";
}
