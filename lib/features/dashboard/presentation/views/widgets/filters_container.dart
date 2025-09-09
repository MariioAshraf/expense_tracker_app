import 'package:expense_tracker_app/core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../constants.dart';
import '../../../../../features/transactions/domain/entities/filters.dart';
import '../../../../transactions/presentation/manager/get_transactions_bloc/get_transactions_bloc.dart';
class FiltersContainer extends StatefulWidget {
  const FiltersContainer({super.key});

  @override
  State<FiltersContainer> createState() => _FiltersContainerState();
}

class _FiltersContainerState extends State<FiltersContainer> {
  TransactionDateFilter selectedFilter = TransactionDateFilter.thisMonth;
  void _applyFilter(TransactionDateFilter filter) {
    setState(() {
      selectedFilter = filter;
    });
    if (filter == TransactionDateFilter.thisMonth) {
      context.read<GetTransactionsBloc>().dateController.text =
          TransactionDateFilter.thisMonth.toString();
      context.read<GetTransactionsBloc>().add(LoadTransactionsEvent(
          page: 0, pageSize: 10, dateFilter: TransactionDateFilter.thisMonth));
    } else if (filter == TransactionDateFilter.last7Days) {
      context.read<GetTransactionsBloc>().dateController.text =
          TransactionDateFilter.last7Days.toString();
      context.read<GetTransactionsBloc>().add(LoadTransactionsEvent(
          page: 0, pageSize: 10, dateFilter: TransactionDateFilter.last7Days));
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(50),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<TransactionDateFilter>(
        value: selectedFilter,
        dropdownColor: AppColorsManager.mainBlue,
        underline: const SizedBox(),
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.white,
        ),
        style: const TextStyle(color: Colors.white),
        items: const [
          DropdownMenuItem(
            value: TransactionDateFilter.thisMonth,
            child: Text(kThisMonth),
          ),
          DropdownMenuItem(
            value: TransactionDateFilter.last7Days,
            child: Text(kLast7Days),
          ),
        ],
        onChanged: (value) {
          if (value != null) {
            _applyFilter(value);
          }
        },
      ),
    );
  }
}
