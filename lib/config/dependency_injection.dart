import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc_observer.dart';
import '../core/firebase/firebase_auth_service.dart';
import '../core/firebase/firestore_service.dart';
import '../core/storage/local/app_settings_shared_preferences.dart';
import '../features/auth/presentation/controller/auth_cubit.dart';
import '../features/main/presentation/controller/main_cubit.dart';
import '../firebase_options.dart';

final instance = GetIt.instance;

initModule() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = MyBlocObserver();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  instance.registerLazySingleton<AppSettingsSharedPreferences>(
    () => AppSettingsSharedPreferences(instance()),
  );

  // Services
  instance.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());
  instance.registerLazySingleton<FirestoreService>(() => FirestoreService());
}

initAuth() {
  if (!GetIt.I.isRegistered<AuthCubit>()) {
    instance.registerFactory<AuthCubit>(() => AuthCubit(instance()));
  }
}

disposeAuth(){
  if (GetIt.I.isRegistered<AuthCubit>()) {
    instance.unregister<AuthCubit>();
  }
}

initMain() {
  disposeAuth();
  if (!GetIt.I.isRegistered<MainCubit>()) {
    instance.registerLazySingleton<MainCubit>(() => MainCubit());
  }
}

disposeMain(){
  if (GetIt.I.isRegistered<MainCubit>()) {
    instance.unregister<MainCubit>();
  }
}
