import 'package:expense_tracker_app/core/routing/routes.dart';
import 'package:expense_tracker_app/features/auth/login/presentation/manager/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/login/domain/use_cases/login_use_case.dart';
import '../../features/auth/login/presentation/views/login_view.dart';
import '../di/dependency_injection.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginView:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LoginBloc(getIt.get<LoginUseCase>()),
            child: const LoginView(),
          ),
        );
      default:
        return null;
    }
  }
}
