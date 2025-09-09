import 'package:expense_tracker_app/core/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';
import '../../../../../constants.dart';
import '../../../domain/entities/filters.dart';
import '../../manager/transactions_bloc/add_transaction_bloc.dart';

class TransactionTypeTextFormField extends StatefulWidget {
  const TransactionTypeTextFormField({super.key});

  @override
  State<TransactionTypeTextFormField> createState() =>
      _TransactionTypeTextFormFieldState();
}

class _TransactionTypeTextFormFieldState
    extends State<TransactionTypeTextFormField> {
  @override
  Widget build(BuildContext context) {
    final bloc = AddTransactionsBloc.get(context);
    final transactionTypeController = bloc.transactionTypeController;

    return AppTextFormField(
      hintText: 'Type',
      controller: transactionTypeController,
      readOnly: true,
      suffixIcon: DropdownButtonHideUnderline(
        child: DropdownButton<TransactionTypeFilter>(
          dropdownColor: Colors.white,
          hint: const Text("Select"),
          value: _getEnumFromText(transactionTypeController.text),
          items: TransactionTypeFilter.values.map((filter) {
            return DropdownMenuItem<TransactionTypeFilter>(
              value: filter,
              child: Text(_mapEnumToText(filter)),
            );
          }).toList(),
          onChanged: (filter) {
            setState(() {
              if (filter != null) {
                transactionTypeController.text = _mapEnumToText(filter);
              }
            });
          },
        ),
      ),
    );
  }

  String _mapEnumToText(TransactionTypeFilter filter) {
    switch (filter) {
      case TransactionTypeFilter.income:
        return kIncome;
      case TransactionTypeFilter.expense:
        return kExpense;
    }
  }

  TransactionTypeFilter? _getEnumFromText(String text) {
    switch (text) {
      case kIncome:
        return TransactionTypeFilter.income;
      case kExpense:
        return TransactionTypeFilter.expense;
      default:
        return null;
    }
  }
}
