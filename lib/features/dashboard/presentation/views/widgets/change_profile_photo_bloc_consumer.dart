import 'package:expense_tracker_app/features/dashboard/presentation/views/widgets/profile_image_shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../manager/dash_board_bloc.dart';
import 'build_user_profile_image.dart';

class ChangeProfilePhotoBlocConsumer extends StatelessWidget {
  const ChangeProfilePhotoBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashBoardBloc, DashBoardState>(
      listener: (context, state) {
        if (state is PickProfilePhotoSuccess) {
          context.read<DashBoardBloc>().add(ChangeUserImageEvent());
        }
        if (state is ChangeProfilePhotoSuccess) {
          context.read<DashBoardBloc>().userModel.profileImageUrl =
              state.profileImageUrl;
        }
      },
      builder: (context, state) {
        if (state is ChangeProfilePhotoLoading) {
          return ClipOval(
            child: CircleAvatar(
              radius: 30.r,
              child: ProfileImageShimmerLoading(),
            ),
          );
        }
        return buildUserProfileImage(
          context,
          radius: 30,
          profileImage:
              context.read<DashBoardBloc>().userModel.profileImageUrl!,
        );
      },
    );
  }
}
