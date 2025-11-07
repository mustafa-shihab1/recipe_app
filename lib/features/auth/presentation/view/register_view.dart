import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/firebase/firestore_service.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/validators/validators.dart';
import '../../../../routes/routes.dart';
import '../controller/auth_cubit.dart';
import '../controller/auth_state.dart';
import 'widgets/auth_appbar.dart';
import 'widgets/auth_text_field.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AuthAppBar(switchText: 'Login'),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoadingState) {
            Utils.showLoadingDialog(context);
          } else if (state is AuthSuccessState) {
            FirestoreService.saveUserData(state.user.uid, {
              'name': _nameController.text.trim(),
              'email': _emailController.text.trim(),
              'createdAt': DateTime.now().toIso8601String(),
            });
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
                              'Register',
                              style: Theme.of(context).textTheme.headlineLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Create your account to get started.',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 30),
                            AuthTextField(
                              controller: _nameController,
                              hintText: 'Full Name',
                              validator: (name) =>
                                  Validators.validateName(name),
                            ),
                            const SizedBox(height: 15),
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
                            const SizedBox(height: 15),
                            AuthTextField(
                              controller: _confirmPasswordController,
                              hintText: 'Confirm Password',
                              obscureText: true,
                              validator: (password) =>
                                  Validators.validatePassword(password),
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<AuthCubit>().register(
                                      name: _nameController.text.trim(),
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text
                                          .trim(),
                                      confirmPassword:
                                          _confirmPasswordController.text
                                              .trim(),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                  ),
                                  backgroundColor: Theme.of(
                                    context,
                                  ).primaryColor,
                                ),
                                child: const Text(
                                  'Register',
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
