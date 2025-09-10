import 'package:expense_tracker_app/features/dashboard/presentation/views/widgets/total_expense_row.dart';
import 'package:expense_tracker_app/features/dashboard/presentation/views/widgets/total_income_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../transactions/data/models/totals_model.dart';
import 'animated_total_balance.dart';

class TotalExpenseAndIncomeContainer extends StatelessWidget {
  const TotalExpenseAndIncomeContainer({super.key, required this.totals});
final Totals totals;
  @override
  Widget build(BuildContext context) {

    final formattedBalance =
        NumberFormat.currency(symbol: "\$").format(totals.balance);
    final height = MediaQuery.of(context).size.height;
    return Positioned(
      top: height * 0.18,
      left: 20.w,
      right: 20.w,
      child: Container(
        padding: EdgeInsets.all(16.w),
        height: height * 0.28,
        decoration: BoxDecoration(
          color: AppColorsManager.primaryBlue,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AnimatedTotalBalance(
                formattedBalance: formattedBalance,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Income
                  TotalIncomeRow(totalIncome: totals.income),
                  // Expenses
                  TotalExpenseRow(totalExpense: totals.expense),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
