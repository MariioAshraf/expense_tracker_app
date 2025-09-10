import 'package:expense_tracker_app/core/utils/extensions.dart';
import 'package:expense_tracker_app/features/transactions/presentation/views/widgets/add_transaction_view_body.dart';
import 'package:flutter/material.dart';
import '../../../../core/theming/app_styles.dart';
import '../manager/transactions_bloc/add_transaction_bloc.dart';

class AddTransactionView extends StatefulWidget {
  const AddTransactionView({super.key});

  @override
  State<AddTransactionView> createState() => _AddTransactionViewState();
}

class _AddTransactionViewState extends State<AddTransactionView> {
  late AddTransactionsBloc addTransactionBloc;
  @override
  void initState() {
    addTransactionBloc = AddTransactionsBloc.get(context);
    super.initState();
  }

  @override
  void dispose() {
    addTransactionBloc.disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: Text(
          'Add Transaction',
          style: AppTextStyles.font18BlackBold,
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: AddTransactionViewBody()),
    );
  }
}
