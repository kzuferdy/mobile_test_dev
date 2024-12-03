import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_test_dev/logic/dashboard/dashboard_bloc.dart';
import 'package:mobile_test_dev/logic/login/login_bloc.dart';
import 'package:mobile_test_dev/pages/login_page.dart';


void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => UserBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'Login Dashboard App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}