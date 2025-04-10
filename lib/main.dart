import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/auth/auth_bloc.dart';
import 'routes/app_routes.dart';
import 'screens/sign_in_screen.dart';
import 'screens/calendar_screen.dart';

void main() {
  runApp(const FlexRiseApp());
}

class FlexRiseApp extends StatelessWidget {
  const FlexRiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        title: 'FlexRise',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: AppRoutes.signIn,
        routes: {
          AppRoutes.signIn: (context) => SignInScreen(),
          AppRoutes.calendar: (context) => const CalendarScreen(),
        },
      ),
    );
  }
}