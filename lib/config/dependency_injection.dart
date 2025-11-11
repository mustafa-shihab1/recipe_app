import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc_observer.dart';
import '../core/firebase/firebase_auth_service.dart';
import '../core/firebase/firestore_service.dart';
import '../core/storage/local/app_settings_shared_preferences.dart';
import '../core/storage/local/database/controller/recipe_database_controller.dart';
import '../core/storage/local/database/provider/database_provider.dart';
import '../features/MyRecipes/presentation/controller/my_recipes_cubit.dart';
import '../features/addRecipe/presentation/controller/add_recipe_cubit.dart';
import '../features/auth/presentation/controller/auth_cubit.dart';
import '../features/home/presentation/controller/home_cubit.dart';
import '../features/recipeDetails/presentation/controller/recipe_details_cubit.dart';
import '../features/search/presentation/controller/search_cubit.dart';
import '../features/main/presentation/controller/main_cubit.dart';
import '../firebase_options.dart';

final instance = GetIt.instance;

initModule() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = MyBlocObserver();
  await DatabaseProvider().initDatabase();

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  instance.registerLazySingleton<AppSettingsSharedPreferences>(
    () => AppSettingsSharedPreferences(instance()),
  );

  // Firebase Services
  instance.registerLazySingleton<FirebaseAuthService>(
    () => FirebaseAuthService(),
  );
  instance.registerLazySingleton<FirestoreService>(() => FirestoreService());

  instance.registerLazySingleton<RecipeDatabaseController>(
    () => RecipeDatabaseController(),
  );

  instance.registerLazySingleton<http.Client>(() => http.Client());
}

initAuth() {
  if (!GetIt.I.isRegistered<AuthCubit>()) {
    instance.registerFactory<AuthCubit>(() => AuthCubit(instance()));
  }
}

disposeAuth() {
  if (GetIt.I.isRegistered<AuthCubit>()) {
    instance.unregister<AuthCubit>();
  }
}

initMain() {
  disposeAuth();
  if (!GetIt.I.isRegistered<MainCubit>()) {
    instance.registerLazySingleton<MainCubit>(() => MainCubit());
    instance.registerLazySingleton<HomeCubit>(() => HomeCubit(instance()));
    instance.registerLazySingleton<MyRecipesCubit>(
      () => MyRecipesCubit(instance()),
    );
  }
}

disposeMain() {
  if (GetIt.I.isRegistered<MainCubit>()) {
    instance.unregister<MainCubit>();
  }
}

initSearch() {
  if (!GetIt.I.isRegistered<SearchCubit>()) {
    instance.registerLazySingleton<SearchCubit>(() => SearchCubit(instance()));
  }
}

disposeSearch() {
  if (GetIt.I.isRegistered<SearchCubit>()) {
    instance.unregister<SearchCubit>();
  }
}

initAddRecipe() {
  if (!GetIt.I.isRegistered<AddRecipeCubit>()) {
    instance.registerFactory<AddRecipeCubit>(() => AddRecipeCubit(instance()));
  }
}

initRecipeDetails() {
  if (!GetIt.I.isRegistered<RecipeDetailsCubit>()) {
    instance.registerFactory<RecipeDetailsCubit>(
      () => RecipeDetailsCubit(instance()),
    );
  }
}
