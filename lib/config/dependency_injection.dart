import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/services/firebase_auth_service.dart';
import '../core/services/firestore_service.dart';
import '../core/storage/local/app_settings_shared_preferences.dart';
import '../features/auth/presentation/controller/auth_cubit.dart';
import '../features/main/presentation/controller/main_cubit.dart';
import '../firebase_options.dart';

final instance = GetIt.instance;

initModule() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  instance.registerLazySingleton<AppSettingsSharedPreferences>(
    () => AppSettingsSharedPreferences(instance()),
  );

  // Services
  instance.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());
  instance.registerLazySingleton<FirestoreService>(() => FirestoreService());

  // Cubits
  instance.registerLazySingleton<AuthCubit>(() => AuthCubit(instance()));

  // Register MainCubit as a factory
  instance.registerFactory<MainCubit>(() => MainCubit(instance(), instance()));
}
