import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_text_form_field.dart';
import '../../manager/add_transaction_bloc.dart';

class AmountAndCurrencyConversionTextFormField extends StatefulWidget {
  const AmountAndCurrencyConversionTextFormField({super.key});

  @override
  State<AmountAndCurrencyConversionTextFormField> createState() =>
      _AmountAndCurrencyConversionTextFormFieldState();
}

class _AmountAndCurrencyConversionTextFormFieldState
    extends State<AmountAndCurrencyConversionTextFormField> {
  late TextEditingController currencyController;

  @override
  void initState() {
    currencyController = context.read<AddTransactionBloc>().currencyController;
    currencyController.text = "EGP";
    super.initState();
  }

  final List<DropdownMenuItem<String>> currencies = [
    DropdownMenuItem(value: "EGP", child: Text("EGP")),
    DropdownMenuItem(value: "USD", child: Text("USD")),
    DropdownMenuItem(value: "EUR", child: Text("EUR")),
    DropdownMenuItem(value: "GBP", child: Text("GBP")),
  ];

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      suffixIcon: DropdownButton<String>(
        hint: const Text("Currency"),
        items: currencies,
        onChanged: (value) {
          setState(() {
            // selectedCurrency = value!;
            currencyController.text = value!;
          });
        },
      ),
      prefixIcon: SizedBox(
          height: 5.h,
          width: 5.w,
          child: Center(
              child: Text(
                currencyController.text,
            textAlign: TextAlign.center,
          ))),
      controller: context.read<AddTransactionBloc>().amountController,
      hintText: 'Amount',
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
        color: Colors.transparent,
      )),
    );
  }
}
