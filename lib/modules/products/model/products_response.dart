// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

List<Products> productsFromJson(List<dynamic> jsonData) =>
    jsonData.map((item) => Products.fromJson(item)).toList();

String productsToJson(List<Products> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Products {
  int? id;

  String? title;
  String? content;
  String? image;
  String? thumbnail;

  int? item;
  int? price;
  Products({
    this.id,
    this.title,
    this.content,
    this.image,
    this.thumbnail,
    this.item = 0,
    this.price,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        image: json["image"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "image": image,
        "thumbnail": thumbnail,
      };
}
