import 'package:cook_recipe/screens/norecipe_screen.dart';
import 'package:cook_recipe/screens/recipe_card.dart';
import 'package:cook_recipe/database/db.dart';
import 'package:cook_recipe/database/recipe_data.dart';
import 'package:extended_image/extended_image.dart';
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
                  color: Colors.green,
                  fontWeight: FontWeight.w800,
                  fontSize: 25),
            ),
            Text(
              "Food",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 25),
            )
          ]),
        ),
        body: Container(
          color: Colors.grey.shade200,
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
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                      width: 35,
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
              Row(
                children: [
                  Text(
                    "My",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.yellow[800],
                        fontWeight: FontWeight.w700),
                  ),
                  const Text(
                    " Favorites Recipe",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              FutureBuilder(
                future: recipeDB,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: Row(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final item = snapshot.data![index];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      NoRecipScreen(
                                                          recipeName:
                                                              item.recipeName),
                                                  fullscreenDialog: true))
                                          .then((value) {
                                        setState(() {
                                          recipeDB = getRecipeDB();
                                        });
                                      });
                                    },
                                    child: Stack(
                                      children: [
                                        ColorFiltered(
                                          colorFilter: ColorFilter.mode(
                                              Colors.black.withOpacity(0.6),
                                              BlendMode.darken),
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                            child: ExtendedImage.network(
                                              item.img,
                                              width: 380,
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
                                        Positioned(
                                          width: 380,
                                          left: 0,
                                          bottom: 0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(item.recipeName,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w800)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              )
            ],
          ),
        ));
  }
}
