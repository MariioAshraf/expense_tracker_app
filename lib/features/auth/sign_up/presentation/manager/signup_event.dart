part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

class SignUpSubmitted extends SignupEvent {
  final String name;
  final String email;
  final String password;

  SignUpSubmitted({
    required this.name,
    required this.email,
    required this.password,
  });
}
