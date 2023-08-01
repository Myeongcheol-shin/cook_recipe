import 'package:cook_recipe/models/recipe.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class RecipeContent extends StatefulWidget {
  final Recipe recipe;

  const RecipeContent({super.key, required this.recipe});

  @override
  State<RecipeContent> createState() => _RecipeContentState();
}

class _RecipeContentState extends State<RecipeContent> {
  List<List<String?>> recipeList = [];

  List<List<String?>> getRecipeList() {
    final recipeList = [
      [widget.recipe.recipe1, widget.recipe.recipImg1],
      [widget.recipe.recipe2, widget.recipe.recipImg2],
      [widget.recipe.recipe3, widget.recipe.recipImg3],
      [widget.recipe.recipe4, widget.recipe.recipImg4],
      [widget.recipe.recipe5, widget.recipe.recipImg5],
      [widget.recipe.recipe6, widget.recipe.recipImg6],
      [widget.recipe.recipe7, widget.recipe.recipImg7],
      [widget.recipe.recipe8, widget.recipe.recipImg8],
      [widget.recipe.recipe9, widget.recipe.recipImg9],
      [widget.recipe.recipe10, widget.recipe.recipImg10],
      [widget.recipe.recipe11, widget.recipe.recipImg11],
      [widget.recipe.recipe12, widget.recipe.recipImg12],
      [widget.recipe.recipe13, widget.recipe.recipImg13],
      [widget.recipe.recipe14, widget.recipe.recipImg14],
      [widget.recipe.recipe15, widget.recipe.recipImg15],
      [widget.recipe.recipe16, widget.recipe.recipImg16],
      [widget.recipe.recipe17, widget.recipe.recipImg17],
      [widget.recipe.recipe18, widget.recipe.recipImg18],
      [widget.recipe.recipe19, widget.recipe.recipImg19],
    ];
    recipeList.removeWhere((element) => element.first == "");
    return recipeList;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      recipeList = getRecipeList();
    });
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
      body: Container(
        padding: const EdgeInsets.only(top: 15),
        color: Colors.grey.shade300,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: recipeList.length,
          itemBuilder: (context, index) {
            final recipeData = recipeList[index];
            if (recipeData[0] != "" && recipeData[1] != "") {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                margin:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                child: Column(
                  children: [
                    Text("${index + 1}단계",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w700)),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: ExtendedImage.network(
                        recipeData[1]!,
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
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      recipeData[0]!.substring(3).split("\n").join(" "),
                      softWrap: true,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
