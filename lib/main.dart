import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'config/dependency_injection.dart' as di;
import 'features/auth/presentation/controller/auth_cubit.dart';
import 'features/main/presentation/controller/main_cubit.dart';
import 'routes/routes.dart';

void main() async {
  await di.initModule();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.instance<AuthCubit>()),
        BlocProvider(create: (context) => di.instance<MainCubit>()),
      ],
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.appStartView,
      ),
    );
  }
}

//
