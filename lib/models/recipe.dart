class Recipe {
  final String recipeName, image1, ingredient;
  Recipe.jsonDecode(Map<String, dynamic> json)
      : recipeName = json['RCP_NM'],
        image1 = json['ATT_FILE_NO_MK'],
        ingredient = json['RCP_PARTS_DTLS'];
}

class Cook {
  final Success suc;
  Cook.jsonDecode(Map<String, dynamic> json) : suc = json['COOKRCP01'];
}

class Success {
  final String totalCount;
  final List<Recipe> recipes;

  Success.jsonDecode(Map<String, dynamic> json)
      : totalCount = json['total_count'],
        recipes = json['row'];
}
