import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/functions/hive_functions.dart';
import '../../../models/user_model.dart';
import '../../data/models/login_input_body_model.dart';
import '../../domain/use_cases/login_use_case.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  static LoginBloc get(context) => BlocProvider.of(context);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? userId;
  late UserModel userModel;

  LoginBloc(this.loginUseCase) : super(LoginInitial()) {
    on<LoginRequestedEvent>(_onLoginRequested);
    on<DisposeControllersEvent>(_onDisposeControllers);
  }

  Future<void> _onLoginRequested(
      LoginRequestedEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    final loginInputBodyModel = LoginInputBodyModel(
      email: event.email,
      password: event.password,
    );

    final result = await loginUseCase.call(loginInputBodyModel);

    await result.fold(
      (failure) {
        emit(LoginFailure(errMessage: failure.message));
      },
      (userModel) async {
        userId = userModel.uId;
        await HiveFunctions.saveUserId(userModel.uId!);
        this.userModel = userModel;
        emit(LoginSuccess(userModel));
      },
    );
  }

  void _onDisposeControllers(
      DisposeControllersEvent event, Emitter<LoginState> emit) {
    emailController.dispose();
    passwordController.dispose();
  }
}
