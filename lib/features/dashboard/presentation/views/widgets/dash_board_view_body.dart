import 'package:expense_tracker_app/core/theming/app_styles.dart';
import 'package:expense_tracker_app/features/dashboard/presentation/views/widgets/total_expense_and_income_container.dart';
import 'package:expense_tracker_app/features/dashboard/presentation/views/widgets/welcome_and_filters_container.dart';
import 'package:expense_tracker_app/features/transactions/presentation/manager/get_transactions_bloc/get_transactions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../transactions/domain/entities/filters.dart';
import '../../../../transactions/presentation/views/widgets/get_transaction_bloc_consumer.dart';

class DashBoardViewBody extends StatefulWidget {
  const DashBoardViewBody({super.key});

  @override
  State<DashBoardViewBody> createState() => _DashBoardViewBodyState();
}

class _DashBoardViewBodyState extends State<DashBoardViewBody> {
  @override
  void initState() {
    context.read<GetTransactionsBloc>().add(LoadTransactionsEvent(
        page: 0, pageSize: 10, dateFilter: TransactionDateFilter.thisMonth));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height * 0.48,
          child: Stack(
            children: [
              WelcomeAndFiltersContainer(height: height),
              BlocBuilder<GetTransactionsBloc, GetTransactionsState>(
                buildWhen: (_, current) => current is CalculateTotalsSuccess,
                builder: (context, state) {
                  return state is CalculateTotalsSuccess
                      ? TotalExpenseAndIncomeContainer(totals: state.totals)
                      : Container();
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 10.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Expenses',
                style: AppTextStyles.font18BlackBold,
              ),
              Text('see all ', style: AppTextStyles.font14BlackMedium)
            ],
          ),
        ),
        Expanded(
          child: GetTransactionsBlocConsumer(),
        ),
      ],
    );
  }
}
