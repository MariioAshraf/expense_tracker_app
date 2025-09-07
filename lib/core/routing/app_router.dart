import 'package:expense_tracker_app/core/routing/routes.dart';
import 'package:expense_tracker_app/features/auth/login/presentation/manager/login_bloc.dart';
import 'package:expense_tracker_app/features/auth/sign_up/presentation/views/sign_up_view.dart';
import 'package:expense_tracker_app/features/dashboard/presentation/views/dash_board_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/add_transaction/data/repos/transaction_repo_impl.dart';
import '../../features/add_transaction/domain/use_cases/add_transaction_use_case.dart';
import '../../features/add_transaction/presentation/manager/add_transaction_bloc.dart';
import '../../features/add_transaction/presentation/views/add_transaction_view.dart';
import '../../features/auth/login/domain/use_cases/login_use_case.dart';
import '../../features/auth/login/presentation/views/login_view.dart';
import '../../features/dashboard/presentation/manager/dash_board_bloc.dart';
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
      case Routes.signUpView:
        return MaterialPageRoute(
          builder: (_) => const SignUpView(),
        );
      case Routes.dashBoardView:
        return MaterialPageRoute(
          builder: (_) => DashBoardView(),
        );
      case Routes.addTransactionView:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                AddTransactionBloc(getIt.get<AddTransactionUseCase>()),
            child: AddTransactionView(),
          ),
        );
      default:
        return null;
    }
  }
}
