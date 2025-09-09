import 'package:expense_tracker_app/core/theming/app_colors.dart';
import 'package:expense_tracker_app/features/dashboard/presentation/views/widgets/user_name_and_image_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'filters_container.dart';

class WelcomeAndFiltersContainer extends StatelessWidget {
  const WelcomeAndFiltersContainer({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.38,
      decoration: BoxDecoration(
        color: AppColorsManager.mainBlue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: height * 0.07,
          left: 20.w,
          right: 20.w,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const UserNameAndImageRow(),
            const FiltersContainer(),
          ],
        ),
      ),
    );
  }
}
