import 'package:cook_recipe/database/recipe_data.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'recipe.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<int> add(RecipeDB recipeDB) async {
    Database db = await instance.database;
    return await db.insert('Recipe', recipeDB.toMap());
  }

  Future<List<RecipeDB>> getRecipe() async {
    Database db = await instance.database;
    var recipeDb = await db.query("Recipe", orderBy: "id");
    List<RecipeDB> recipeList = recipeDb.isNotEmpty
        ? recipeDb.map((e) => RecipeDB.fromMap(e)).toList()
        : [];

    return recipeList;
  }

  Future<bool> checkRecipeExists(String serialNumber) async {
    Database db = await instance.database;
    final query = await db.rawQuery(
      'SELECT EXISTS(SELECT 1 FROM Recipe WHERE serialNumber = ?)',
      [serialNumber],
    );
    return Sqflite.firstIntValue(query) == 1;
  }

  Future<int> remove(String serial) async {
    Database db = await instance.database;
    return await db
        .delete('Recipe', where: 'serialNumber = ?', whereArgs: [serial]);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE Recipe(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      serialNumber TEXT NOT NULL,
      recipeName TEXT NOT NULL,
      img TEXT NOT NULL
    )
    ''');
  }
}
