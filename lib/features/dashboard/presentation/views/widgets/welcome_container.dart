import 'package:expense_tracker_app/features/dashboard/presentation/manager/dash_board_bloc.dart';
import 'package:expense_tracker_app/features/dashboard/presentation/views/widgets/user_name_and_image_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_colors.dart';

class WelcomeContainer extends StatelessWidget {
  const WelcomeContainer({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.38,
      decoration: BoxDecoration(
          color: AppColorsManager.mainBlue,
          borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.only(
          top: height * 0.07,
          left: 20.w,
        ),
        child: UserNameAndImageRow(),
      ),
    );
  }
}
