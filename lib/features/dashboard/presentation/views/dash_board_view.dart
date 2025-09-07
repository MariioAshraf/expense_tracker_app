import 'package:expense_tracker_app/core/theming/app_colors.dart';
import 'package:expense_tracker_app/core/utils/extensions.dart';
import 'package:expense_tracker_app/features/dashboard/presentation/views/widgets/dash_board_view_body.dart';
import 'package:flutter/material.dart';

import '../../../../core/routing/routes.dart';

class DashBoardView extends StatelessWidget {
  const DashBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColorsManager.mainBlue,
        onPressed: () {
          context.pushNamed(Routes.addTransactionView);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: DashBoardViewBody(),
    );
  }
}
