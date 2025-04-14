import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flex_rise/bloc/auth/auth_bloc.dart';
import 'package:flex_rise/bloc/auth/auth_event.dart';

void main() {
  group('AuthBloc', () {
    late AuthBloc authBloc;

    setUp(() {
      authBloc = AuthBloc();
    });

    tearDown(() {
      authBloc.close();
    });

    test('initial state is false', () {
      expect(authBloc.state, false);
    });

    blocTest<AuthBloc, bool>(
      'emits [true] when SignInRequested is added with valid credentials',
      build: () => authBloc,
      act: (bloc) => bloc.add(const SignInRequested(email: 'test@email.com', password: 'password')),
      expect: () => [true],
    );

    blocTest<AuthBloc, bool>(
      'emits [] when SignInRequested is added with empty credentials',
      build: () => authBloc,
      act: (bloc) => bloc.add(const SignInRequested(email: '', password: '')),
      expect: () => [],
    );
  });
}