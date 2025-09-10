import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../core/theming/app_styles.dart';

class TotalIncomeRow extends StatelessWidget {
  const TotalIncomeRow({
    super.key,
    required this.totalIncome,
  });

  final double totalIncome;

  @override
  Widget build(BuildContext context) {
    final formattedIncome =
        NumberFormat.currency(symbol: "\$").format(totalIncome);
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: Colors.white.withAlpha(50),
          child: const Icon(
            Icons.arrow_downward,
            color: Colors.greenAccent,
            size: 18,
          ),
        ),
        SizedBox(width: 8.w),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Income',
              style: AppTextStyles.font18WhiteSemiBold,
              textAlign: TextAlign.center,
            ),
            Text(
              formattedIncome,
              style: AppTextStyles.font18WhiteSemiBold,
            ),
          ],
        ),
      ],
    );
  }
}
