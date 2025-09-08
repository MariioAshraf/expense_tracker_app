import 'dart:io';
import 'package:expense_tracker_app/core/theming/app_colors.dart';
import 'package:expense_tracker_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../manager/transactions_bloc/add_transaction_bloc.dart';

class AddTransactionBlocConsumer extends StatelessWidget {
  const AddTransactionBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddTransactionsBloc, AddTransactionsState>(
      listener: (context, state) {
        if (state is AddTransactionSuccessState) {
          context.pop(true);
        }
      },
      builder: (context, state) => state is TransactionFilePickedSuccessState
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              height: 200.h,
              width: double.infinity,
              child: Image.file(
                File(
                  state.filePath,
                ),
                fit: BoxFit.fill,
              ),
            )
          : GestureDetector(
              onTap: () {
                context.read<AddTransactionsBloc>().add(PickFileEvent());
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                height: 50.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColorsManager.basicGrey,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(children: [
                  Icon(Icons.add_photo_alternate),
                  Text('Attach Receipt'),
                ]),
              ),
            ),
    );
  }
}
