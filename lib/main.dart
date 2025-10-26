import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/features/auth/presentation/controller/auth_cubit.dart';
import 'core/theme/app_theme.dart';
import 'config/dependency_injection.dart' as di;
import 'core/widgets/app_start_view.dart';

void main() async {
  await di.initModule();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.instance<AuthCubit>(),
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const AppStartView(), // This is the correct entry point
      ),
    );
  }
}
//