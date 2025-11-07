class ApiConstants {
  // Base URL for TheMealDB API
  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1/';

  // --- ENDPOINTS ---

  /// Search for a meal by name (e.g., search.php?s=Arrabiata)
  static const String search = 'search.php';

  /// Lookup full meal details by id (e.g., lookup.php?i=52772)
  static const String lookup = 'lookup.php';

  /// Lookup a single random meal
  static const String random = 'random.php';

  /// List all meal categories
  static const String categories = 'categories.php';

  /// List all categories, areas, or ingredients
  /// (e.g., list.php?c=list, list.php?a=list, list.php?i=list)
  static const String list = 'list.php';

  /// Filter by category, area, or main ingredient
  /// (e.g., filter.php?c=Seafood, filter.php?a=Canadian, filter.php?i=chicken_breast)
  static const String filter = 'filter.php';
}
