import 'package:flutter/material.dart';
import '../../../../../../core/theming/app_styles.dart';
import '../../../../../../core/utils/app_regex.dart';
import '../../../../../../core/theming/app_colors.dart';
import '../../../../../../core/utils/spacing.dart';
import '../../../../../../core/widgets/app_text_form_field.dart';
import '../../manager/login_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    var loginBloc = LoginBloc.get(context);
    return Form(
      key: loginBloc.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email',
            style: AppTextStyles.font16BlackBold,
          ),
          verticalSpacing(4),
          AppTextFormField(
            backGroundColor: AppColorsManager.basicGrey,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !AppRegex.isEmailValid(value)) {
                return 'please enter a valid email';
              }
            },
            controller: loginBloc.emailController,
            hintText: 'Enter your email',
          ),
          verticalSpacing(12),
          Text(
            'Password',
            style: AppTextStyles.font16BlackBold,
          ),
          verticalSpacing(4),
          AppTextFormField(
            backGroundColor: AppColorsManager.basicGrey,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            controller: loginBloc.passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'please enter a valid password';
              }
            },
            obscureText: isObscureText,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isObscureText = !isObscureText;
                });
              },
              icon: Icon(
                isObscureText ? Icons.visibility_off : Icons.visibility,
                color: AppColorsManager.grey,
              ),
            ),
            hintText: 'Password',
          ),
        ],
      ),
    );
  }
}
