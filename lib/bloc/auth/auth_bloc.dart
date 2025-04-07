import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, bool> {
  AuthBloc() : super(false) { // false means not authenticated initially
    on<SignInRequested>((event, emit) {
      // For now, we'll simulate a successful sign-in
      if (event.email.isNotEmpty && event.password.isNotEmpty) {
        emit(true); // User is authenticated
      }
    });

    on<SignUpRequested>((event, emit) {
      // Simulate a successful sign-up
      if (event.email.isNotEmpty && event.password.isNotEmpty) {
        emit(true); // User is authenticated
      }
    });
  }
}