import 'package:expense_tracker_app/core/theming/app_colors.dart';
import 'package:expense_tracker_app/core/utils/extensions.dart';
import 'package:expense_tracker_app/features/dashboard/presentation/views/widgets/dash_board_view_body.dart';
import 'package:expense_tracker_app/features/transactions/presentation/manager/get_transactions_bloc/get_transactions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/routing/routes.dart';

class DashBoardView extends StatefulWidget {
  const DashBoardView({super.key});

  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  late GetTransactionsBloc _getTransactionsBloc;

  @override
  void initState() {
    _getTransactionsBloc = context.read<GetTransactionsBloc>();
    super.initState();
  }

  _loadTransactions() {
    _getTransactionsBloc.add(LoadTransactionsEvent(page: 0, pageSize: 10));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
