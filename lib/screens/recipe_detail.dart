import 'package:cook_recipe/models/recipe.dart';
import 'package:cook_recipe/screens/recipe_content.dart';
import 'package:cook_recipe/database/db.dart';
import 'package:cook_recipe/database/recipe_data.dart';
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
  late Future<bool> favorites;
  int dbUpdateLoading = 0;
  @override
  void initState() {
    super.initState();
    ingredients = widget.recipe.ingredient.split(",");
    ingredients.sort((a, b) => a.length.compareTo(b.length));
    favorites = checkFavorites();
  }

  Future<bool> checkFavorites() async {
    return await DatabaseHelper.instance
        .checkRecipeExists(widget.recipe.serialNumber);
  }

  setFavorite() async {
    if (await DatabaseHelper.instance
        .checkRecipeExists(widget.recipe.serialNumber)) {
      dbUpdateLoading =
          await DatabaseHelper.instance.remove(widget.recipe.serialNumber);
      setState(() {
        favorites = Future.value(false);
      });
    } else {
      dbUpdateLoading = await DatabaseHelper.instance.add(RecipeDB(
          serialNumber: widget.recipe.serialNumber,
          recipeName: widget.recipe.recipeName,
          img: widget.recipe.image1));
      setState(() {
        favorites = Future.value(true);
      });
    }
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
          actions: [
            FutureBuilder(
              future: favorites,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return IconButton(
                      onPressed: () {
                        setFavorite();
                      },
                      icon: snapshot.data == true
                          ? const Icon(Icons.bookmark_rounded)
                          : const Icon(Icons.bookmark_border_rounded));
                } else {
                  return const SizedBox();
                }
              },
            )
          ],
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
                                fontSize: 24),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20),
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
                                    item.split("\n").join(),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          alignment: Alignment.topLeft,
                          child: const Text(
                            "영양성분",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: const Text(
                                          "칼로리 : ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 5),
                                        margin: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            color: Colors.deepOrange.shade200,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5))),
                                        child: Text(
                                          widget.recipe.infoEng == null
                                              ? "정보없음"
                                              : "${widget.recipe.infoEng}kcal",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: const Text(
                                          "나트륨 : ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 5),
                                        margin: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            color: Colors.deepOrange.shade200,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5))),
                                        child: Text(
                                          widget.recipe.infoNa == null
                                              ? "정보없음"
                                              : "${widget.recipe.infoNa}g",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: const Text(
                                          "탄수화물 : ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 5),
                                        margin: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            color: Colors.deepOrange.shade200,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5))),
                                        child: Text(
                                          widget.recipe.infoCar == null
                                              ? "정보없음"
                                              : "${widget.recipe.infoCar}g",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: const Text(
                                          "단백질 : ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 5),
                                        margin: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            color: Colors.deepOrange.shade200,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5))),
                                        child: Text(
                                          widget.recipe.infoPro == null
                                              ? "정보없음"
                                              : "${widget.recipe.infoPro}g",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: const Text(
                                      "지방 : ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 3, horizontal: 5),
                                    margin: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        color: Colors.deepOrange.shade200,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5))),
                                    child: Text(
                                      widget.recipe.infoFat == null
                                          ? "정보없음"
                                          : "${widget.recipe.infoFat}g",
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          ),
          Positioned(
            left: 80,
            right: 80,
            bottom: 30,
            child: Container(
              height: 40,
              margin: const EdgeInsets.only(bottom: 40),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 1.0,
                    spreadRadius: 1.0,
                    offset: const Offset(1, 2))
              ], borderRadius: BorderRadius.circular(20), color: Colors.green),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RecipeContent(recipe: widget.recipe),
                          fullscreenDialog: true));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "레시피 보러가기",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
