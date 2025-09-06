import 'package:expense_tracker_app/core/utils/extensions.dart';
import 'package:expense_tracker_app/features/auth/login/presentation/manager/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/routing/routes.dart';
import '../../../../../../core/theming/app_colors.dart';
import '../../../../../../core/theming/app_styles.dart';
import '../../../../../dashboard/presentation/manager/dash_board_bloc.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      child: const SizedBox.shrink(),
      listener: (context, state) {
        if (state is LoginFailure) {
          context.pop();
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              icon: const Icon(
                Icons.error,
                color: Colors.red,
                size: 32,
              ),
              content: Text(state.errMessage),
              actions: [
                TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: Text(
                    'Got it',
                    style: AppTextStyles.font14DarkBlueMedium,
                  ),
                ),
              ],
            ),
          );
        }
        if (state is LoginSuccess) {
          context.read<DashBoardBloc>().userModel = state.userModel;
          context.pop();
          context.pushReplacementNamed(Routes.dashBoardView);
        }
        if (state is LoginLoading) {
          showDialog(
            context: context,
            builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: AppColorsManager.mainBlue,
              ),
            ),
          );
        }
      },
    );
  }
}
