import 'package:cook_recipe/models/recipe.dart';
import 'package:cook_recipe/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';

class RecipeScreen extends StatefulWidget {
  final String recipe;

  const RecipeScreen({super.key, required this.recipe});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen>
    with TickerProviderStateMixin {
  late Future<List<Recipe>> recipes;

  int start = 1;
  int end = 10;
  @override
  void initState() {
    recipes = ApiService.getRecipe(widget.recipe, start, end);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.green),
          title:
              Text(widget.recipe, style: const TextStyle(color: Colors.black)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: recipes,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.6),
                                  BlendMode.darken),
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: ExtendedImage.network(
                                  snapshot.data![index].image1,
                                  width: double.infinity,
                                  height: 200,
                                  cache: true,
                                  fit: BoxFit.cover,
                                  headers: const {
                                    "User-Agent":
                                        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, bottom: 10),
                              child: Text(
                                snapshot.data![index].recipeName,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ));
  }
}
