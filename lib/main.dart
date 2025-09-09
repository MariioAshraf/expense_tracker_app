import 'package:expense_tracker_app/core/di/dependency_injection.dart';
import 'package:expense_tracker_app/features/auth/models/user_model.dart';
import 'package:expense_tracker_app/features/dashboard/data/repos/dash_board_repo_impl.dart';
import 'package:expense_tracker_app/features/dashboard/presentation/manager/dash_board_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'constants.dart';
import 'core/functions/hive_functions.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'core/utils/bloc_observer.dart';
import 'core/utils/supabase_initialization.dart';
import 'features/transactions/data/models/transaction_model.dart';
import 'features/transactions/domain/entities/filters.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await supabaseInitialization();
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionModelAdapter());
  Hive.registerAdapter(TransactionTypeFilterAdapter());
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>(kUsersBox);
  await Hive.openBox<TransactionModel>(kTransactionsBox);
  final user = await HiveFunctions.getUserModel();
  setupServiceLocator();
  Bloc.observer = AppBlocObserver();
  await ScreenUtil.ensureScreenSize();
  runApp(MyApp(
    user: user,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.user});

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(375, 812),
      child: BlocProvider(
        create: (context) => DashBoardBloc(
          dashBoardRepo: getIt.get<DashBoardRepoImpl>(),
        ),
        child: MaterialApp(
          initialRoute: user == null ? Routes.loginView : Routes.dashBoardView,
          onGenerateRoute: (settings) =>
              AppRouter().generateRoute(settings, user: user),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
