import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:login_test_task/presentation/cubit/auth/auth_cubit.dart';
import 'package:login_test_task/presentation/ui/login/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.username});

  final String username;
  static String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.initial) {
              GoRouter.of(context).pushReplacementNamed(LoginScreen.routeName);
            } else if (state.status == AuthStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  cubit.errorMessage,
                  style: const TextStyle(color: Colors.black, fontSize: 22),
                ),
                backgroundColor: Colors.grey,
              ));
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome, $username",
                style: const TextStyle(color: Colors.black, fontSize: 22),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  cubit.logout();
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
