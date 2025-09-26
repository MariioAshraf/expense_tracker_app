import 'package:expense_tracker_app/core/theming/app_colors.dart';
import 'package:expense_tracker_app/core/utils/extensions.dart';
import 'package:expense_tracker_app/features/dashboard/presentation/views/widgets/dash_board_view_body.dart';
import 'package:expense_tracker_app/features/transactions/presentation/manager/get_transactions_bloc/get_transactions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/services/export_pdf_service.dart';
import '../../../auth/models/user_model.dart';
import '../../../transactions/domain/entities/filters.dart';
import '../manager/dash_board_bloc.dart';

class DashBoardView extends StatefulWidget {
  const DashBoardView({super.key, this.userModel});

  final UserModel? userModel;

  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  late GetTransactionsBloc _getTransactionsBloc;

  @override
  void initState() {
    if (widget.userModel != null) {
      context.read<DashBoardBloc>().userModel = widget.userModel;
    }
    _getTransactionsBloc = context.read<GetTransactionsBloc>();
    super.initState();
  }

  TransactionDateFilter? _mapStringToDateFilter(String value) {
    switch (value) {
      case transactionDateFilterThisMonth:
        return TransactionDateFilter.thisMonth;
      case transactionDateFilterLast7Days:
        return TransactionDateFilter.last7Days;
      default:
        return null;
    }
  }

  _loadTransactions() {
    final filter =
        _mapStringToDateFilter(_getTransactionsBloc.dateController.text);
    _getTransactionsBloc
        .add(LoadTransactionsEvent(page: 0, pageSize: 10, dateFilter: filter));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Dashboard"),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.picture_as_pdf),
      //       onPressed: () async {
      //         await TransactionsExportService.exportToPDF(
      //             _getTransactionsBloc.allTransactions);
      //       },
      //     ),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColorsManager.mainBlue,
        onPressed: () async {
          final result = await context.pushNamed(Routes.addTransactionView);
          if (result == true) {
            _loadTransactions();
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: DashBoardViewBody(),
    );
  }
}
