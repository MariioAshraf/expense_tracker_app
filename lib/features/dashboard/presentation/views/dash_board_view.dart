import 'package:expense_tracker_app/features/dashboard/presentation/views/widgets/dash_board_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/dash_board_bloc.dart';

class DashBoardView extends StatelessWidget {
  const DashBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DashBoardViewBody(),
    );
  }
}
