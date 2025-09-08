import 'package:expense_tracker_app/core/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';
import '../../manager/transactions_bloc/add_transaction_bloc.dart';

class TransactionTypeTextFormField extends StatelessWidget {
  const TransactionTypeTextFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final transactionTypeController =
        AddTransactionsBloc.get(context).transactionTypeController;
    return AppTextFormField(
      hintText: 'Type',
      controller: transactionTypeController,
      readOnly: true,
      suffixIcon: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: const Text("Select"),
          items: const [
            DropdownMenuItem(value: "Income", child: Text("Income")),
            DropdownMenuItem(value: "Expense", child: Text("Expense")),
          ],
          onChanged: (value) {
            transactionTypeController.text = value!;
          },
        ),
      ),
    );
  }
}
