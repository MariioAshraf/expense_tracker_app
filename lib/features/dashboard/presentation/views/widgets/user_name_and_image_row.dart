import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theming/app_styles.dart';
import '../../../../../core/utils/spacing.dart';
import '../../manager/dash_board_bloc.dart';
import 'change_profile_photo_bloc_consumer.dart';

class UserNameAndImageRow extends StatelessWidget {
  const UserNameAndImageRow({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<DashBoardBloc>().userModel;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            context.read<DashBoardBloc>().add(PickUserImageEvent());
          },
          child: ChangeProfilePhotoBlocConsumer(),
        ),
        horizontalSpacing(20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getGreetingMessage(),
            verticalSpacing(5),
            Text(
              '${user.name[0].toUpperCase()}${user.name.substring(1)}',
              style: AppTextStyles.font16WhiteSemiBold,
            ),
          ],
        ),
      ],
    );
  }

  Widget _getGreetingMessage() {
    final now = DateTime.now();
    final hour = now.hour;

    if (hour < 12) {
      return Text(
        "Good Morning",
        style: AppTextStyles.font14WhiteRegular,
      );
    } else if (hour < 18) {
      return Text(
        "Good Afternoon",
        style: AppTextStyles.font14WhiteRegular,
      );
    } else {
      return Text(
        "Good Evening",
        style: AppTextStyles.font14WhiteRegular,
      );
    }
  }
}
