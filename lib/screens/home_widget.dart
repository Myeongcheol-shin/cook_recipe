import 'package:cook_recipe/screens/recipe_card.dart';
import 'package:cook_recipe/database/db.dart';
import 'package:cook_recipe/database/recipe_data.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late Future<List<RecipeDB>> recipeDB;
  @override
  void initState() {
    super.initState();
    recipeDB = getRecipeDB();
  }

  Future<List<RecipeDB>> getRecipeDB() async {
    return await DatabaseHelper.instance.getRecipe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Row(children: [
          Text(
            "Shino",
            style: TextStyle(
                color: Colors.green, fontWeight: FontWeight.w800, fontSize: 25),
          ),
          Text(
            "Food",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w800, fontSize: 25),
          )
        ]),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text(
                  "Recipe Type",
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                    width: 50,
                    child: Image.asset(
                      'assets/images/icon_chef.png',
                    )),
              ],
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RecipeCard(recipe: "국"),
                                  fullscreenDialog: true))
                          .then((value) {
                        setState(() {
                          recipeDB = getRecipeDB();
                        });
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.7),
                                blurRadius: 2.0,
                                spreadRadius: 2.0,
                                offset: const Offset(2, 3))
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.soup_kitchen,
                              size: 130,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "국",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RecipeCard(recipe: "밥"),
                              fullscreenDialog: true));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.7),
                                blurRadius: 2.0,
                                spreadRadius: 2.0,
                                offset: const Offset(2, 3))
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.rice_bowl,
                              size: 130,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "밥",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RecipeCard(recipe: "반찬"),
                              fullscreenDialog: true));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.7),
                                blurRadius: 2.0,
                                spreadRadius: 2.0,
                                offset: const Offset(2, 3))
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.dining_sharp,
                              size: 130,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "반찬",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RecipeCard(recipe: "후식"),
                              fullscreenDialog: true));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.7),
                                blurRadius: 2.0,
                                spreadRadius: 2.0,
                                offset: const Offset(2, 3))
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.cookie,
                              size: 130,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "후식",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Row(
              children: [
                Text(
                  "Favorites",
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.star_rate_rounded,
                  color: Colors.yellow,
                  size: 50,
                )
              ],
            ),
            FutureBuilder(
              future: recipeDB,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Text(
                          snapshot.data![index].recipeName,
                          style: const TextStyle(color: Colors.black),
                        );
                      },
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
