import 'package:expense_tracker_app/features/dashboard/presentation/views/widgets/total_expense_row.dart';
import 'package:expense_tracker_app/features/dashboard/presentation/views/widgets/total_income_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../manager/dash_board_bloc.dart';
import 'animated_total_balance.dart';

class TotalExpenseAndIncomeContainer extends StatefulWidget {
  const TotalExpenseAndIncomeContainer({super.key});

  @override
  State<TotalExpenseAndIncomeContainer> createState() =>
      _TotalExpenseAndIncomeContainerState();
}

class _TotalExpenseAndIncomeContainerState
    extends State<TotalExpenseAndIncomeContainer> {
  @override
  Widget build(BuildContext context) {
    final user = context.read<DashBoardBloc>().userModel!;
    final height = MediaQuery.of(context).size.height;

    return Positioned(
      top: height * 0.18,
      left: 20.w,
      right: 20.w,
      child: BlocBuilder<DashBoardBloc, DashBoardState>(
        buildWhen: (previous, current) => current is UpdateUserSuccess,
        builder: (context, state) {
          final balance = user.totalIncome - user.totalExpense;
          final formattedBalance =
              NumberFormat.currency(symbol: "\$").format(balance);
          return Container(
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
                      TotalIncomeRow(totalIncome: user.totalIncome),
                      // Expenses
                      TotalExpenseRow(totalExpense: user.totalExpense),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
