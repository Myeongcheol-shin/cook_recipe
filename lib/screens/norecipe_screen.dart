import 'package:cook_recipe/database/db.dart';
import 'package:cook_recipe/database/recipe_data.dart';
import 'package:cook_recipe/models/recipe.dart';
import 'package:cook_recipe/screens/recipe_content.dart';
import 'package:cook_recipe/services/api_service.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class NoRecipScreen extends StatefulWidget {
  const NoRecipScreen({super.key, required this.recipeName});

  final String recipeName;
  @override
  State<NoRecipScreen> createState() => _NoRecipScreenState();
}

class _NoRecipScreenState extends State<NoRecipScreen> {
  late Recipe recipe;
  Future<bool> favorites = Future.value(true);
  late List<String> ingredients;

  int dbUpdateLoading = 0;

  late Future<Recipe?> frecipe;

  Future<bool> checkFavorites() async {
    return await DatabaseHelper.instance.checkRecipeExists(recipe.serialNumber);
  }

  setFavorite() async {
    if (await DatabaseHelper.instance.checkRecipeExists(recipe.serialNumber)) {
      dbUpdateLoading =
          await DatabaseHelper.instance.remove(recipe.serialNumber);
      setState(() {
        favorites = Future.value(false);
      });
    } else {
      dbUpdateLoading = await DatabaseHelper.instance.add(RecipeDB(
          serialNumber: recipe.serialNumber,
          recipeName: recipe.recipeName,
          img: recipe.image1));
      setState(() {
        favorites = Future.value(true);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    frecipe = ApiService.getRecipeForName(widget.recipeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
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
              widget.recipeName,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600),
            )),
        body: FutureBuilder(
          future: frecipe,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              recipe = snapshot.data!;
              ingredients = recipe.ingredient.split(",");
              ingredients.sort((a, b) => a.length.compareTo(b.length));
              favorites = checkFavorites();

              return Stack(
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
                                    recipe.image1,
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
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Text(
                                    recipe.recipeName,
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
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
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
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 14),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 3,
                                                        horizontal: 5),
                                                margin: const EdgeInsets.all(3),
                                                decoration: BoxDecoration(
                                                    color: Colors
                                                        .deepOrange.shade200,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                5))),
                                                child: Text(
                                                  recipe.infoEng == null
                                                      ? "정보없음"
                                                      : "${recipe.infoEng}kcal",
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700),
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
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 14),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 3,
                                                        horizontal: 5),
                                                margin: const EdgeInsets.all(3),
                                                decoration: BoxDecoration(
                                                    color: Colors
                                                        .deepOrange.shade200,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                5))),
                                                child: Text(
                                                  recipe.infoNa == null
                                                      ? "정보없음"
                                                      : "${recipe.infoNa}g",
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700),
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
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 14),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 3,
                                                        horizontal: 5),
                                                margin: const EdgeInsets.all(3),
                                                decoration: BoxDecoration(
                                                    color: Colors
                                                        .deepOrange.shade200,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                5))),
                                                child: Text(
                                                  recipe.infoCar == null
                                                      ? "정보없음"
                                                      : "${recipe.infoCar}g",
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700),
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
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 14),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 3,
                                                        horizontal: 5),
                                                margin: const EdgeInsets.all(3),
                                                decoration: BoxDecoration(
                                                    color: Colors
                                                        .deepOrange.shade200,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                5))),
                                                child: Text(
                                                  recipe.infoPro == null
                                                      ? "정보없음"
                                                      : "${recipe.infoPro}g",
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700),
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
                                                color:
                                                    Colors.deepOrange.shade200,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5))),
                                            child: Text(
                                              recipe.infoFat == null
                                                  ? "정보없음"
                                                  : "${recipe.infoFat}g",
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
                                ),
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
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 1.0,
                                spreadRadius: 1.0,
                                offset: const Offset(1, 2))
                          ],
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.green),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RecipeContent(recipe: recipe),
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
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
