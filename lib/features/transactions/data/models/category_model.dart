import 'package:flutter/material.dart';

class CategoryModel {
  final String name;
  final IconData icon;
  final Color color;

  CategoryModel({
    required this.name,
    required this.icon,
    required this.color,
  });

  static final List<CategoryModel> defaultCategories = [
    CategoryModel(name: "Entertainment", icon: Icons.movie, color: Colors.blue),
    CategoryModel(
        name: "Gas", icon: Icons.local_gas_station, color: Colors.redAccent),
    CategoryModel(
        name: "Shopping", icon: Icons.shopping_bag, color: Colors.orange),
    CategoryModel(
        name: "Transport", icon: Icons.directions_car, color: Colors.purple),
    CategoryModel(name: "Food", icon: Icons.fastfood, color: Colors.green),
  ];
}
