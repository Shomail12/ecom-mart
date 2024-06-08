// To parse this JSON data, do
//
//     final catergoryModel = catergoryModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CatergoryModel catergoryModelFromJson(String str) => CatergoryModel.fromJson(json.decode(str));

class CatergoryModel {
  List<Catergory> catergories;

  CatergoryModel({
    required this.catergories,
  });

  factory CatergoryModel.fromJson(Map<String, dynamic> json) => CatergoryModel(
    catergories: List<Catergory>.from(json["catergories"].map((x) => Catergory.fromJson(x))),
  );


}

class Catergory {
  String name;
  List<String> subcatergory;

  Catergory({
    required this.name,
    required this.subcatergory,
  });

  factory Catergory.fromJson(Map<String, dynamic> json) => Catergory(
    name: json["name"],
    subcatergory: List<String>.from(json["subcatergory"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "subcatergory": List<dynamic>.from(subcatergory.map((x) => x)),
  };
}
