import 'package:cook_recipe/models/recipe.dart';
import 'package:cook_recipe/services/api_service.dart';
import 'package:flutter/material.dart';

class RecipeScreen extends StatefulWidget {
  final String recipe;

  const RecipeScreen({super.key, required this.recipe});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  late Future<List<Recipe>> recipes;

  @override
  void initState() {
    super.initState();
    recipes = ApiService.getRecipe("국");
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
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: recipes,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Text(
                          snapshot.data![index].recipeName,
                          style: const TextStyle(color: Colors.black),
                        ),
                        Image.network(
                          snapshot.data![index].image1,
                          headers: const {
                            "User-Agent":
                                "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                          },
                        )
                      ],
                    );
                    return null;
                  },
                );
              }
              return const SizedBox();
            },
          ),
        ));
  }
}
