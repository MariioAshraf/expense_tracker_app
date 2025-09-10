import 'package:expense_tracker_app/features/auth/sign_up/presentation/manager/signup_bloc.dart';
import 'package:expense_tracker_app/features/auth/sign_up/presentation/views/widgets/sign_up_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../domain/use_cases/sign_up_use_case.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocProvider(
          create: (context) => SignUpBloc(getIt.get<SignUpUseCase>()),
          child: const SafeArea(child: SignUpViewBody()),
        ));
  }
}
