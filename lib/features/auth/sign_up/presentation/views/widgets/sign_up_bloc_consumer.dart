import 'package:expense_tracker_app/core/utils/extensions.dart';
import 'package:expense_tracker_app/features/auth/sign_up/presentation/manager/signup_bloc.dart';
import 'package:expense_tracker_app/features/auth/sign_up/presentation/manager/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/routing/routes.dart';
import '../../../../../../core/theming/app_colors.dart';
import '../../../../../../core/theming/app_styles.dart';
import '../../../../../../core/widgets/app_text_button.dart';

class SignUpBlocConsumer extends StatelessWidget {
  const SignUpBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final signUpBloc = SignUpBloc.get(context);
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpFailure) {
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
                    style: AppTextStyles.font14BlackMedium,
                  ),
                )
              ],
            ),
          );
        }
        if (state is SignUpSuccess) {
          _showSuccessMessage(context);
          context.pushReplacementNamed(Routes.loginView);
        }
      },
      builder: (context, state) {
        return AppTextButton(
          onPressed: () async {
            if (signUpBloc.formKey.currentState!.validate()) {
              signUpBloc.add(
                SignUpSubmitted(
                  name: signUpBloc.nameController.text,
                  email: signUpBloc.emailController.text,
                  password: signUpBloc.passwordController.text,
                ),
              );
            }
          },
          child: state is SignUpLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.sp,
                  ),
                )
              : Text(
                  'Sign Up',
                  style: AppTextStyles.font16WhiteSemiBold,
                ),
        );
      },
    );
  }
}

void _showSuccessMessage(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        'Account created successfully',
        style: AppTextStyles.font14BlackMedium,
      ),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
        label: 'Ok',
        textColor: AppColorsManager.darkBlue,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ),
  );
}
