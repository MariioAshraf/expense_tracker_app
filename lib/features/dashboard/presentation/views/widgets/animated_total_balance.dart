import 'package:expense_tracker_app/core/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_styles.dart';

class AnimatedTotalBalance extends StatefulWidget {
  const AnimatedTotalBalance({super.key, required this.formattedBalance});

  final String formattedBalance;

  @override
  State<AnimatedTotalBalance> createState() => _AnimatedTotalBalanceState();
}

class _AnimatedTotalBalanceState extends State<AnimatedTotalBalance> {
  bool showBalance = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Total Balance', style: AppTextStyles.font18WhiteSemiBold),
            IconButton(
                onPressed: () {
                  setState(() {
                    showBalance = !showBalance;
                  });
                },
                icon: Icon(
                  !showBalance
                      ? Icons.arrow_drop_down_outlined
                      : Icons.arrow_drop_up_outlined,
                  color: Colors.white,
                ))
          ],
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 150),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -0.2),
                end: Offset.zero,
              ).animate(animation),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: showBalance
              ? Text(
                  widget.formattedBalance,
                  key: const ValueKey("balance_shown"),
                  style: AppTextStyles.font22WhiteSemiBold
                      .copyWith(fontSize: 26.sp),
                )
              : const SizedBox(
                  key: ValueKey("balance_hidden"),
                ),
        ),
      ],
    );
  }
}
