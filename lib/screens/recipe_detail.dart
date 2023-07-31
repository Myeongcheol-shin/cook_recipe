import 'package:cook_recipe/models/recipe.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class RecipeDetail extends StatefulWidget {
  final Recipe recipe;
  const RecipeDetail({super.key, required this.recipe});

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  late List<String> ingredients;
  @override
  void initState() {
    super.initState();
    ingredients = widget.recipe.ingredient.split(",");
    ingredients.sort((a, b) => a.length.compareTo(b.length));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.green.shade200],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: Text(
            widget.recipe.recipeName,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600),
          )),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.green.shade200],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const SizedBox(
              height: 150,
              width: double.infinity,
            ),
          ),
          Center(
            child: Container(
              width: 350,
              padding: const EdgeInsets.only(top: 50),
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            blurRadius: 2.0,
                            spreadRadius: 2.0,
                            offset: const Offset(2, 3))
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          child: ExtendedImage.network(
                            widget.recipe.image1,
                            width: 350,
                            height: 200,
                            cache: true,
                            fit: BoxFit.cover,
                            headers: const {
                              "User-Agent":
                                  "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(
                            widget.recipe.recipeName,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          alignment: Alignment.topLeft,
                          child: const Text(
                            "재료",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 10),
                          width: 350,
                          child: Wrap(
                            children: [
                              for (var item in ingredients)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 5),
                                  margin: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
