import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theming/app_colors.dart';
import '../theming/app_styles.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required this.hintText,
    this.hintStyle,
    this.inputTextStyle,
    this.suffixIcon,
    this.obscureText,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.backGroundColor,
    this.courserColor,
    this.controller,
    this.validator,
    this.onChanged,
    this.readOnly,
    this.prefixIcon,
    this.keyboardType,
  });

  final String hintText;
  final void Function(String?)? onChanged;
  final TextEditingController? controller;
  final TextStyle? hintStyle;
  final Color? backGroundColor;
  final Color? courserColor;
  final TextStyle? inputTextStyle;
  final Widget? suffixIcon;
  final bool? obscureText;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final Function(String?)? validator;
  final bool? readOnly;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      readOnly: readOnly ?? false,
      onChanged: onChanged,
      validator: (value) {
        if (validator == null) {
          return null;
        }
        return validator!(value);
      },
      controller: controller,
      cursorOpacityAnimates: true,
      cursorColor: courserColor ?? AppColorsManager.mainBlue,
      obscureText: obscureText ?? false,
      style: inputTextStyle ?? AppTextStyles.font14BlackMedium,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.3,
            ),
            borderRadius: BorderRadius.circular(6)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.3,
            ),
            borderRadius: BorderRadius.circular(6)),
        filled: true,
        fillColor: backGroundColor ?? AppColorsManager.basicGrey,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
              horizontal: 18.w,
              vertical: 10.h,
            ),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColorsManager.mainBlue,
                  width: 1.3,
                ),
                borderRadius: BorderRadius.circular(6)),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColorsManager.lighterGrey,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
        hintStyle: hintStyle ?? AppTextStyles.font14LightGreyRegular,
        hintText: hintText,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
