class Recipe {
  final String recipeName, image1, ingredient;
  final String? recipe1,
      recipe2,
      recipe3,
      recipe4,
      recipe5,
      recipe6,
      recipe7,
      recipe8,
      recipe9,
      recipe10,
      recipe11,
      recipe12,
      recipe13,
      recipe14,
      recipe15,
      recipe16,
      recipe17,
      recipe18,
      recipe19,
      recipImg1,
      recipImg2,
      recipImg3,
      recipImg4,
      recipImg5,
      recipImg6,
      recipImg7,
      recipImg8,
      recipImg9,
      recipImg10,
      recipImg11,
      recipImg12,
      recipImg13,
      recipImg14,
      recipImg15,
      recipImg16,
      recipImg17,
      recipImg18,
      recipImg19;
  Recipe.jsonDecode(Map<String, dynamic> json)
      : recipeName = json['RCP_NM'],
        recipe1 = json['MANUAL01'],
        recipe2 = json['MANUAL02'],
        recipe3 = json['MANUAL03'],
        recipe4 = json['MANUAL04'],
        recipe5 = json['MANUAL05'],
        recipe6 = json['MANUAL06'],
        recipe7 = json['MANUAL07'],
        recipe8 = json['MANUAL08'],
        recipe9 = json['MANUAL09'],
        recipe10 = json['MANUAL10'],
        recipe11 = json['MANUAL11'],
        recipe12 = json['MANUAL12'],
        recipe13 = json['MANUAL13'],
        recipe14 = json['MANUAL14'],
        recipe15 = json['MANUAL15'],
        recipe16 = json['MANUAL16'],
        recipe17 = json['MANUAL17'],
        recipe18 = json['MANUAL18'],
        recipe19 = json['MANUAL19'],
        recipImg1 = json['MANUAL_IMG01'],
        recipImg2 = json['MANUAL_IMG02'],
        recipImg3 = json['MANUAL_IMG03'],
        recipImg4 = json['MANUAL_IMG04'],
        recipImg5 = json['MANUAL_IMG05'],
        recipImg6 = json['MANUAL_IMG06'],
        recipImg7 = json['MANUAL_IMG07'],
        recipImg8 = json['MANUAL_IMG08'],
        recipImg9 = json['MANUAL_IMG09'],
        recipImg10 = json['MANUAL_IMG10'],
        recipImg11 = json['MANUAL_IMG11'],
        recipImg12 = json['MANUAL_IMG12'],
        recipImg13 = json['MANUAL_IMG13'],
        recipImg14 = json['MANUAL_IMG14'],
        recipImg15 = json['MANUAL_IMG15'],
        recipImg16 = json['MANUAL_IMG16'],
        recipImg17 = json['MANUAL_IMG17'],
        recipImg18 = json['MANUAL_IMG18'],
        recipImg19 = json['MANUAL_IMG19'],
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
