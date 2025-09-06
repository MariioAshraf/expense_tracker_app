import 'package:expense_tracker_app/core/di/dependency_injection.dart';
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
import 'features/dashboard/data/repos/dash_board_repo.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await supabaseInitialization();
  await Hive.initFlutter();
  await HiveFunctions.openBox();
  setupServiceLocator();
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          initialRoute: Routes.loginView,
          onGenerateRoute: AppRouter().generateRoute,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
