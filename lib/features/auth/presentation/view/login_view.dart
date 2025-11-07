import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/validators/validators.dart';
import '../../../../routes/routes.dart';
import '../controller/auth_cubit.dart';
import '../controller/auth_state.dart';
import 'widgets/auth_appbar.dart';
import 'widgets/auth_text_field.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AuthAppBar(switchText: 'Register'),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoadingState) {
            Utils.showLoadingDialog(context);
          } else if (state is AuthSuccessState) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.mainView,
              (route) => false,
            );
          } else if (state is AuthErrorState) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            Utils.showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Image.asset(
                AssetsManager.ornament,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Login',
                              style: Theme.of(context).textTheme.headlineLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Welcome back! Please login to your account.',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 30),
                            AuthTextField(
                              controller: _emailController,
                              hintText: 'Email',
                              validator: (email) =>
                                  Validators.validateEmail(email),
                            ),
                            const SizedBox(height: 15),
                            AuthTextField(
                              controller: _passwordController,
                              hintText: 'Password',
                              obscureText: true,
                              validator: (password) =>
                                  Validators.validatePassword(password),
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: ColorsManager.primaryColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<AuthCubit>().login(
                                      _emailController.text.trim(),
                                      _passwordController.text.trim(),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                  ),
                                  backgroundColor: ColorsManager.primaryColor,
                                ),
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
