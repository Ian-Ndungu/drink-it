// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:drinkit/utils/colors.dart';

class CategoryChip extends StatelessWidget {
  final String category;
  final bool isSelected;
  final ValueChanged<String> onSelected;

  const CategoryChip({
    Key? key,
    required this.category,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelected(category),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.pageColor : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? Border.all(color: AppColors.styleColor, width: 2)
              : null,
        ),
        child: Text(
          category,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
