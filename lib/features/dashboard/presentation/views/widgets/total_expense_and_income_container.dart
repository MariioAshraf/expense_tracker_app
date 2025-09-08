import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theming/app_colors.dart';
class TotalExpenseAndIncomeContainer extends StatelessWidget {
  const TotalExpenseAndIncomeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Positioned(
      top: height * 0.18,
      left: 20.w,
      right: 20.w,
      child: Container(
        height: height * 0.28,
        decoration: BoxDecoration(
          color: AppColorsManager.primaryBlue,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}