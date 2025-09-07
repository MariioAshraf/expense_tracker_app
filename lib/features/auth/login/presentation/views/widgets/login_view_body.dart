import 'package:expense_tracker_app/core/utils/assets.dart';
import 'package:expense_tracker_app/core/utils/extensions.dart';
import 'package:expense_tracker_app/features/auth/login/presentation/manager/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/routing/routes.dart';
import '../../../../../../core/theming/app_styles.dart';
import '../../../../../../core/utils/spacing.dart';
import '../../../../../../core/widgets/app_text_button.dart';
import 'login_bloc_listener.dart';
import 'login_form.dart';
import 'package:flutter/gestures.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  late LoginBloc loginBloc;

  @override
  void initState() {
    loginBloc = LoginBloc.get(context);
    super.initState();
  }

  @override
  void dispose() {
    loginBloc.add(DisposeControllersEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var loginBloc = LoginBloc.get(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            verticalSpacing(40),
            Image.asset(
              AssetsData.loginExpenseLogo,
              width: 180.w,
            ),
            verticalSpacing(60),
            Text(
              'Login',
              style: AppTextStyles.font32BlackBold,
            ),
            verticalSpacing(30),
            const LoginForm(),
            verticalSpacing(22),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Forgot Password?',
                style: AppTextStyles.font13BlueRegular,
              ),
            ),
            verticalSpacing(22),
            const LoginBlocListener(),
            AppTextButton(
              onPressed: () async {
                if (loginBloc.formKey.currentState!.validate()) {
                  loginBloc.add(
                    LoginRequestedEvent(
                      email: loginBloc.emailController.text,
                      password: loginBloc.passwordController.text,
                    ),
                  );
                }
              },
              child: Text(
                'Login',
                style: AppTextStyles.font16WhiteSemiBold,
              ),
            ),
            verticalSpacing(40),
            Text.rich(TextSpan(
              children: [
                TextSpan(
                  text: 'Don\'t have an account yet? ',
                  style: AppTextStyles.font14BlackMedium
                      .copyWith(fontSize: 13.sp),
                ),
                TextSpan(
                    text: ' Sign Up',
                    style: AppTextStyles.font13BlueRegular,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.pushReplacementNamed(Routes.signUpView);
                      }),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
