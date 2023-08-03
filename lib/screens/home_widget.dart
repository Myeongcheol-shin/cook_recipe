import 'dart:async';
import 'dart:ui';

import 'package:cook_recipe/models/recipe.dart';
import 'package:cook_recipe/screens/ingredients_search.dart';
import 'package:cook_recipe/screens/norecipe_screen.dart';
import 'package:cook_recipe/screens/recipe_card.dart';
import 'package:cook_recipe/database/db.dart';
import 'package:cook_recipe/database/recipe_data.dart';
import 'package:cook_recipe/screens/recipe_detail.dart';
import 'package:cook_recipe/services/api_service.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late Future<List<RecipeDB>> recipeDB;
  late Future<List<Recipe>> recipeInfoList;
  late Future<List<Recipe>> randomRecipe;
  bool isSearch = false;
  bool firstInit = false;
  Timer? _debounce;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    recipeDB = getRecipeDB();
    _searchController.addListener(_onSearchChanged);
    _focusNode.addListener(() => {
          if (!_focusNode.hasFocus) {resetSearchState()}
        });
    recipeInfoList = Future.value([]);
    randomRecipe = ApiService.getRandomRecipe();
  }

  resetSearchState() {
    setState(() {
      isSearch = false;
    });
  }

  Future<void> _onSearchChanged() async {
    if (_searchController.text == "") {
      setState(() {
        firstInit = false;
      });
      return;
    }

    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        firstInit = true;
        isSearch = true;
        recipeInfoList = ApiService.getRecipesForName(_searchController.text);
      });
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
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
          flexibleSpace: Container(
              decoration: isSearch
                  ? BoxDecoration(
                      gradient: LinearGradient(
                      colors: [Colors.green, Colors.green.shade200],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ))
                  : const BoxDecoration(color: Colors.white)),
          title: !isSearch
              ? const Row(children: [
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
                ])
              : TextField(
                  focusNode: _focusNode,
                  controller: _searchController,
                  autofocus: false,
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: const InputDecoration(
                    hintText: '검색하고자 하는 레시피를 입력해주세요.',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                  ),
                ),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    isSearch = !isSearch;
                  });
                },
                icon: !isSearch
                    ? const Icon(
                        Icons.search,
                        color: Colors.black,
                      )
                    : const Icon(
                        Icons.close,
                        color: Colors.black,
                      ))
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
            label: const Text(
              "재료로 검색",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            backgroundColor: Colors.green,
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const IngreditentScreen(),
                      fullscreenDialog: true));
            }),
        body: Stack(
          children: [
            GestureDetector(
              onTap: () {},
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
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
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: Image.asset(
                                              'assets/images/icon_soup.png',
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
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
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RecipeCard(recipe: "밥"),
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
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: Image.asset(
                                              'assets/images/icon_rice.png',
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
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
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RecipeCard(recipe: "반찬"),
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
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: Image.asset(
                                              'assets/images/icon_kimchi.png',
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
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
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RecipeCard(recipe: "후식"),
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
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: Image.asset(
                                              'assets/images/icon_desert.png',
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
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
                            "Random",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.red[400],
                                fontWeight: FontWeight.w700),
                          ),
                          const Text(
                            " Recipe",
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
                        future: randomRecipe,
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
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              RecipeDetail(
                                                                  recipe: item),
                                                          fullscreenDialog:
                                                              true))
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
                                                      Colors.black
                                                          .withOpacity(0.6),
                                                      BlendMode.darken),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    child:
                                                        ExtendedImage.network(
                                                      item.image1,
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
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(item.recipeName,
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800)),
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
                            return const SizedBox(
                              height: 200,
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
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
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              NoRecipScreen(
                                                                  recipeName: item
                                                                      .recipeName),
                                                          fullscreenDialog:
                                                              true))
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
                                                      Colors.black
                                                          .withOpacity(0.6),
                                                      BlendMode.darken),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    child:
                                                        ExtendedImage.network(
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
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(item.recipeName,
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800)),
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (isSearch)
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            if (isSearch)
              FutureBuilder(
                future: recipeInfoList,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  if (!firstInit) return const SizedBox();
                  if (snapshot.data!.isEmpty) {
                    return Container(
                        color: Colors.white,
                        child: const ListTile(title: Text("검색 결과 없는 레시피입니다.")));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => Container(
                      color: Colors.white,
                      child: ListTile(
                        title: GestureDetector(
                          onTap: () {
                            setState(() {
                              isSearch = !isSearch;
                              if (isSearch) {
                                Future.delayed(
                                    const Duration(microseconds: 100), () {
                                  FocusScope.of(context)
                                      .requestFocus(_focusNode);
                                });
                              } else {
                                FocusScope.of(context).unfocus();
                                resetSearchState();
                              }
                            });
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NoRecipScreen(
                                            recipeName: snapshot
                                                .data![index].recipeName),
                                        fullscreenDialog: true))
                                .then((value) {
                              setState(() {
                                recipeDB = getRecipeDB();
                              });
                            });
                          },
                          child: Text(
                            snapshot.data![index].recipeName,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
          ],
        ));
  }
}
