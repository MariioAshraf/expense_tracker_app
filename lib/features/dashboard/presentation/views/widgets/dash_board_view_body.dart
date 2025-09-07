import 'package:expense_tracker_app/core/theming/app_styles.dart';
import 'package:expense_tracker_app/features/dashboard/presentation/views/widgets/welcome_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_colors.dart';

class DashBoardViewBody extends StatelessWidget {
  const DashBoardViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height * 0.48,
          child: Stack(
            children: [
              WelcomeContainer(height: height),
              Positioned(
                top: height * 0.18,
                left: 20.w,
                right: 20.w,
                child: Container(
                  height: height * 0.28,
                  decoration: BoxDecoration(
                    color: AppColorsManager.primaryBlue,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 10.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Expenses',
                style: AppTextStyles.font18BlackBold,
              ),
              Text('see all ', style: AppTextStyles.font14BlackMedium)
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("Expense $index"),
              );
            },
          ),
        ),
      ],
    );
  }
}
