import 'dart:convert';
import 'package:cook_recipe/keys/api_key.dart';
import 'package:cook_recipe/models/recipe.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String baseUrl =
      'https://openapi.foodsafetykorea.go.kr/api/${Keys.key}/COOKRCP01/json';

  ApiService();

  static Future<List<Recipe>> getRecipe(String type, int start, int end) async {
    final url = Uri.parse('$baseUrl/$start/$end/RCP_PAT2=$type');
    final response = await http.get(url);

    final List<Recipe> recipes = [];

    if (response.statusCode == 200) {
      final rb = jsonDecode(response.body);
      final items = rb['COOKRCP01']["row"];
      for (var item in items) {
        recipes.add(Recipe.jsonDecode(item));
      }
      return recipes;
    }
    return [];
  }

  static Future<Recipe?> getRecipeForName(String name) async {
    final url = Uri.parse('$baseUrl/1/1/RCP_NM=$name');
    final response = await http.get(url);

    final List<Recipe> recipes = [];

    if (response.statusCode == 200) {
      final rb = jsonDecode(response.body);
      final items = rb['COOKRCP01']["row"];
      for (var item in items) {
        recipes.add(Recipe.jsonDecode(item));
      }
      return recipes[0];
    }
    return null;
  }

  static Future<List<Recipe>> getRecipesForName(String name) async {
    final url = Uri.parse('$baseUrl/1/10/RCP_NM=$name');
    final response = await http.get(url);

    final List<Recipe> recipes = [];

    if (response.statusCode == 200) {
      final rb = jsonDecode(response.body);
      final items = rb['COOKRCP01']["row"];
      if (items == null) return [];
      for (var item in items) {
        recipes.add(Recipe.jsonDecode(item));
      }
      return recipes;
    }
    return [];
  }
}
