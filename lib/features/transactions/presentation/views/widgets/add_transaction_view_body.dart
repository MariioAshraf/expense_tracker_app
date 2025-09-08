import 'package:expense_tracker_app/core/utils/spacing.dart';
import 'package:expense_tracker_app/core/widgets/app_text_button.dart';
import 'package:expense_tracker_app/core/widgets/app_text_form_field.dart';
import 'package:expense_tracker_app/features/transactions/presentation/views/widgets/transaction_type_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_styles.dart';
import '../../manager/transactions_bloc/add_transaction_bloc.dart';
import 'amount_and_currency_conversion_text_form_field.dart';
import 'add_transaction_bloc_consumer.dart';
import 'category_grid_view_builder.dart';
import 'date_picker.dart';

class AddTransactionViewBody extends StatelessWidget {
  const AddTransactionViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final addTransactionBloc = AddTransactionsBloc.get(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _label('Transaction Type'),
            TransactionTypeTextFormField(),
            _label('Categories'),
            AppTextFormField(
              readOnly: true,
              controller: addTransactionBloc.categoryNameController,
              hintText: 'Entertainment',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
            ),
            _label('Amount'),
            AmountAndCurrencyConversionTextFormField(),
            Padding(
              padding: EdgeInsets.only(top: 22.h),
              child: DatePicker(),
            ),
            _label('Attach Receipt'),
            AddTransactionBlocConsumer(),
            verticalSpacing(10),
            _label('Pick a Category'),
            CategoryGridViewBuilder(),
            AppTextButton(
              onPressed: () {
                addTransactionBloc.add(AddTransactionRequestedEvent(
                  amount:
                      double.parse(addTransactionBloc.amountController.text),
                  currency: addTransactionBloc.currencyController.text,
                  date: DateTime.parse(addTransactionBloc.dateController.text),
                  type: addTransactionBloc.transactionTypeController.text,
                  categoryName: addTransactionBloc.categoryNameController.text,
                  categoryIcon:
                      int.parse(addTransactionBloc.categoryIconController.text),
                  receiptPath: addTransactionBloc.receiptController.text,
                ));
              },
              child: Text('Save', style: AppTextStyles.font18WhiteRegular),
            ),
            verticalSpacing(5),
          ],
        ),
      ),
    );
  }

  Widget _label(String label) {
    return Padding(
      padding: EdgeInsets.only(top: 22.h, bottom: 4.h),
      child: Text(
        label,
        style: AppTextStyles.font16BlackBold,
      ),
    );
  }
}
