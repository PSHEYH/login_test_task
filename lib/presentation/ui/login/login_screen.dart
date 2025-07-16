import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:login_test_task/presentation/cubit/auth/auth_cubit.dart';
import 'package:login_test_task/presentation/ui/home/home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  static String routeName = '/login';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthCubit, AuthState>(builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: FormField(builder: (formState) {
                    final cubit = context.read<AuthCubit>();
                    return Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Email'),
                          controller: cubit.emailTextEditingController,
                          validator: cubit.onValidateEmail,
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Password'),
                          controller: cubit.passwordTextEditingController,
                          validator: cubit.onValidatePassword,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await cubit.login();
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: cubit.isValidated
                                          ? Colors.black
                                          : Colors.white),
                                  color: cubit.isValidated
                                      ? Colors.white
                                      : Colors.grey.withOpacity(0.2)),
                              child: state.status == AuthStatus.loading
                                  ? CircularProgressIndicator(
                                      color: Colors.black,
                                    )
                                  : Text(
                                      'Submit',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: cubit.isValidated
                                              ? Colors.black
                                              : Colors.white),
                                    ),
                            )),
                      ],
                    );
                  })),
            ],
          ),
        );
      }, listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          GoRouter.of(context).pushReplacementNamed(HomeScreen.routeName,
              pathParameters: {'username': context.read<AuthCubit>().username});
        } else if (state.status == AuthStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              context.read<AuthCubit>().errorMessage,
              style: const TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.grey,
          ));
        }
      }),
    );
  }
}
