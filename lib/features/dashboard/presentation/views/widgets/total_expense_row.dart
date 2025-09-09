import 'package:expense_tracker_app/core/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../core/theming/app_styles.dart';

class TotalExpenseRow extends StatelessWidget {
  const TotalExpenseRow({
    super.key,
    required this.totalExpense,
  });

  final double totalExpense;

  @override
  Widget build(BuildContext context) {
    final formattedExpense =
        NumberFormat.currency(symbol: "\$").format(totalExpense);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: Colors.white.withAlpha(50),
          child: const Icon(
            Icons.arrow_upward,
            color: Colors.redAccent,
            size: 18,
          ),
        ),
        horizontalSpacing(8),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Expenses', style: AppTextStyles.font18WhiteSemiBold),
            Text(
              formattedExpense,
              style: AppTextStyles.font18WhiteSemiBold,
            ),
          ],
        ),
      ],
    );
  }
}
