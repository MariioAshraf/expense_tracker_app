import 'package:expense_tracker_app/core/services/firestore_service.dart';
import 'package:expense_tracker_app/core/services/supabase_storage_service.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/login/data/repos/login_repo_impl.dart';
import '../../features/auth/login/domain/use_cases/login_use_case.dart';
import '../../features/auth/sign_up/data/repos/sign_up_repo_impl.dart';
import '../../features/auth/sign_up/domain/use_cases/sign_up_use_case.dart';
import '../../features/dashboard/data/repos/dash_board_repo_impl.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // sign up repo dependencies
  getIt.registerSingleton<SignUpRepoImpl>(SignUpRepoImpl());
  getIt
      .registerSingleton<SignUpUseCase>(SignUpUseCase(getIt<SignUpRepoImpl>()));

  // login repo dependencies
  getIt.registerSingleton<LoginRepoImpl>(LoginRepoImpl());
  getIt.registerSingleton<LoginUseCase>(LoginUseCase(getIt<LoginRepoImpl>()));

  // dashboard repo dependencies
  getIt.registerSingleton<DashBoardRepoImpl>(DashBoardRepoImpl(
    storageService: SupabaseStorageService(),
    storeService: FirestoreService(),
  ));
}
