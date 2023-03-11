import 'package:cinema_app_ui/consts.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String category, categoryValue;
  const CategoryItem({
    Key? key,
    required this.icon,
    required this.category,
    required this.categoryValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      width: 102,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              width: 1, color: white, strokeAlign: StrokeAlign.outside)),
      child: Column(
        children: [
          Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(color: white.withOpacity(0.2), blurRadius: 5)
              ]),
              child: Icon(icon, color: white)),
          const SizedBox(height: 5),
          Text(category,
              style:
                  font.copyWith(color: white.withOpacity(0.6), fontSize: 12)),
          const SizedBox(height: 5),
          Text(categoryValue,
              style: font.copyWith(
                  color: white, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
