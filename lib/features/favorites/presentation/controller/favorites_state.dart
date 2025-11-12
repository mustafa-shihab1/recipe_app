import '../../../../core/storage/local/database/model/recipe.dart';

abstract class FavoritesState {}

class InitialFavoritesState extends FavoritesState {}

class LoadedFavoritesState extends FavoritesState {
  List<Recipe> favorites;
  LoadedFavoritesState(this.favorites);
}

class ErrorFavoritesState extends FavoritesState {
  final String message;
  ErrorFavoritesState(this.message);
}
