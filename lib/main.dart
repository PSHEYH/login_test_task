import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_test_task/di/injection.dart';
import 'package:login_test_task/presentation/cubit/auth/auth_cubit.dart';
import 'package:login_test_task/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final authCubit = getIt<AuthCubit>();
    return MultiBlocProvider(
        providers: [BlocProvider<AuthCubit>(create: (_) => authCubit)],
        child: ScreenUtilInit(
            designSize: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height),
            minTextAdapt: true,
            // Use builder only if you need to use library outside ScreenUtilInit context
            builder: (_, child) {
              return MaterialApp.router(
                  title: 'Login test app',
                  routerConfig: router,
                  debugShowCheckedModeBanner: false,
                  color: Colors.white);
            }));
  }
}
