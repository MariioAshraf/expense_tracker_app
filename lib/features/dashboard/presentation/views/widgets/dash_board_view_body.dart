import 'package:expense_tracker_app/features/dashboard/presentation/views/widgets/welcome_container_bloc_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_colors.dart';

class DashBoardViewBody extends StatelessWidget {
  const DashBoardViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: height * 0.48,
          child: Stack(
            children: [
              WelcomeContainerBlocListener(
                height: height,
              ),
              Positioned(
                top: height * 0.18,
                left: 20.w,
                right: 20.w,
                child: Container(
                    height: height * 0.28,
                    decoration: BoxDecoration(
                        color: AppColorsManager.primaryBlue,
                        borderRadius: BorderRadius.circular(16))),
              )
            ],
          ),
        ),
      ],
    );
  }
}
