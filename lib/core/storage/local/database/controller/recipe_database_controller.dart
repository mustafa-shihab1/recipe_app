import 'package:sqflite/sqflite.dart';
import '../../../../../core/storage/local/database/provider/database_provider.dart';
import '../../../../constants/sqflite_constants.dart';
import '../model/recipe.dart';

class RecipeDatabaseController {
  Database? database = DatabaseProvider().database;

  Future<int> insertRecipeToDb(Recipe recipe) async {
    int id = await database!.rawInsert(
      'INSERT INTO ${SqfLiteConstants.tableName}(${SqfLiteConstants.columnName}, ${SqfLiteConstants.columnCategory}, ${SqfLiteConstants.columnArea}, ${SqfLiteConstants.columnInstructions}, ${SqfLiteConstants.columnImage}, ${SqfLiteConstants.columnIsFavorite}) VALUES("${recipe.name}", "${recipe.category}","${recipe.area}","${recipe.instructions}","${recipe.imagePath}","${recipe.isFavorite}")',
    );
    return id;
  }

  Future<List<Recipe>> getRecipesFromDb() async {
    var result = await database!.rawQuery(
      'SELECT * FROM ${SqfLiteConstants.tableName}',
    );
    print(result);
    List<Recipe> recipes = [];
    for (var map in result) {
      Recipe recipe = Recipe.fromMap(map);
      recipes.add(recipe);
    }
    return recipes;
  }

  Future<int> updateRecipeFromDb(Recipe recipe) async {
    int result = await database!.rawUpdate(
      'UPDATE ${SqfLiteConstants.tableName} SET ${SqfLiteConstants.columnName} = "${recipe.name}", ${SqfLiteConstants.columnCategory} = "${recipe.category}", ${SqfLiteConstants.columnArea} = "${recipe.area}", ${SqfLiteConstants.columnInstructions} = "${recipe.instructions}", ${SqfLiteConstants.columnImage} = "${recipe.imagePath}", ${SqfLiteConstants.columnIsFavorite} = "${recipe.isFavorite}" WHERE ${SqfLiteConstants.columnId} = ${recipe.id}',
    );
    return result;
  }

  Future<int> deleteRecipeFromDb(int id) async {
    int countItemsDeleted = await database!.rawDelete(
      'DELETE FROM ${SqfLiteConstants.tableName} WHERE ${SqfLiteConstants.columnId} = ?',
      [id],
    );
    return countItemsDeleted;
  }

  // Future<bool> markAsCompleted(Note object) async {
  //   int countItemsUpdated = await database!.update(
  //       Constants.notesTableName, {Constants.notesIsCompletedColumnName: 1},
  //       where: '${Constants.notesIdColumnName} = ?', whereArgs: [object.id]);
  //   return countItemsUpdated > 0;
  // }

  // Future<List<Note>> readCompleted() async {
  //   List<Map<String, Object?>> data = await database!.query(
  //       Constants.notesTableName,
  //       where: '${Constants.notesIsCompletedColumnName} = ?',
  //       whereArgs: [1]);
  //   return data.map((row) => Note.fromMap(row)).toList();
  // }
}
