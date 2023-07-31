import 'dart:convert';

import 'package:cook_recipe/keys/api_key.dart';
import 'package:cook_recipe/models/recipe.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'https://openapi.foodsafetykorea.go.kr/api/${Key.key}/COOKRCP01/json';

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
}
