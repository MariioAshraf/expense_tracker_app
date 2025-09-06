import 'package:flutter/material.dart';

class DashBoardViewBody extends StatelessWidget {
  const DashBoardViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          'Dashboard',
        ),
      ],
    );
  }
}
