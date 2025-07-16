import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login_test_task/di/injection.dart';
import 'package:login_test_task/presentation/cubit/auth/auth_cubit.dart';
import 'package:login_test_task/presentation/ui/home/home_screen.dart';
import 'package:login_test_task/presentation/ui/login/login_screen.dart';

final GoRouter router = GoRouter(
    initialLocation: LoginScreen.routeName,
    routes: [
      GoRoute(
        path: LoginScreen.routeName,
        name: LoginScreen.routeName,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '${HomeScreen.routeName}/:username',
        name: HomeScreen.routeName,
        builder: (context, state) {
          final String username = state.pathParameters['username'] ?? '';
          return HomeScreen(
            username: username,
          );
        },
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) async {
      final cubit = getIt<AuthCubit>();
      final bool loggedIn = await cubit.checkAuth();
      final bool isLoginRoute = state.matchedLocation == LoginScreen.routeName;
      if (!loggedIn && isLoginRoute) return LoginScreen.routeName;
      if (loggedIn && isLoginRoute) {
        return '${HomeScreen.routeName}/${cubit.username}';
      }
      // no need to redirect at all
      return null;
    });
