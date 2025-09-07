import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/models/category_model.dart';
class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.isSelected,
    required this.category,
  });

  final bool isSelected;
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30.r,
          backgroundColor: isSelected
              ? category.color.withAlpha(200)
              : Colors.transparent,
          child: CircleAvatar(
            radius: 28.r,
            backgroundColor: category.color.withAlpha(70),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Icon(
                category.icon,
                color: category.color,
                size: 28,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          category.name,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}