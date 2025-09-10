import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/register_input_model.dart';
import '../../domain/use_cases/sign_up_use_case.dart';

part 'signup_event.dart';

part 'signup_state.dart';

class SignUpBloc extends Bloc<SignupEvent, SignUpState> {
  final SignUpUseCase signUpUseCase;
  final GlobalKey<FormState> formKey = GlobalKey();

  static SignUpBloc get(context) => BlocProvider.of(context);
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  SignUpBloc(this.signUpUseCase) : super(SignUpInitial()) {
    on<SignUpSubmitted>(_onSignUpSubmitted);
  }

  Future<void> _onSignUpSubmitted(
      SignUpSubmitted event, Emitter<SignUpState> emit) async {
    emit(SignUpLoading());

    final registerInputModel = RegisterInputModel(
      name: event.name,
      email: event.email,
      password: event.password,
    );

    final res = await signUpUseCase.call(registerInputModel);

    res.fold(
      (e) => emit(SignUpFailure(errMessage: e.message)),
      (r) => emit(SignUpSuccess()),
    );
  }
}
