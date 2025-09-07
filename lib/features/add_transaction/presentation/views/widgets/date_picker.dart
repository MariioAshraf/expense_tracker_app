import 'package:expense_tracker_app/core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_styles.dart';
import '../../../../../core/utils/spacing.dart';
import '../../manager/add_transaction_bloc.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    super.key,
  });

  @override
  DatePickerState createState() => DatePickerState();
}

class DatePickerState extends State<DatePicker> {
  DateTime? _selectedDate;
  late TextEditingController _dateController;

  @override
  void initState() {
    _dateController = context.read<AddTransactionBloc>().dateController;
    super.initState();
  }

  Future<void> _pickDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Default date
      firstDate: DateTime.now(), // The earliest date
      lastDate: DateTime(2100), // The latest date
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _dateController.text = picked.toIso8601String();
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Date",
          style: AppTextStyles.font16BlackBold,
        ),
        verticalSpacing(4),
        InkWell(
          onTap: () => _pickDueDate(context),
          child: Container(
            width: double.infinity,
            height: 55.h,
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
            decoration: BoxDecoration(
              color: AppColorsManager.basicGrey,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedDate != null
                      ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
                      : "Pick a date...",
                  style: TextStyle(
                    fontSize: 16,
                    color: _selectedDate != null ? Colors.black : Colors.grey,
                  ),
                ),
                Icon(Icons.calendar_month_outlined,
                    color: _selectedDate != null ? Colors.black : Colors.grey)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
