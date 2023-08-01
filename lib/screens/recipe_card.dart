import 'package:cook_recipe/models/recipe.dart';
import 'package:cook_recipe/screens/recipe_detail.dart';
import 'package:cook_recipe/services/api_service.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class RecipeCard extends StatefulWidget {
  final String recipe;
  const RecipeCard({super.key, required this.recipe});

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  int _start = 1;
  int _end = 5;
  final List<Recipe> _recipes = [];

  late ScrollController _scrollController;

  bool _isFirstRunning = false;
  bool _hasNextPage = true;
  bool _isLoadMore = false;

  @override
  void initState() {
    super.initState();
    _firstLoad();
    _scrollController = ScrollController()..addListener(_loadMore);
  }

  _firstLoad() async {
    setState(() {
      _isFirstRunning = true;
    });
    try {
      final res = await ApiService.getRecipe(widget.recipe, _start, _end);
      setState(() {
        _recipes.addAll(res);
      });
    } catch (e) {}
    setState(() {
      _isFirstRunning = false;
    });
  }

  _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstRunning == false &&
        _isLoadMore == false &&
        _scrollController.position.extentAfter < 200) {
      setState(() {
        _isLoadMore = true;
      });

      _start += 5;
      _end += 5;

      try {
        final res = await ApiService.getRecipe(widget.recipe, _start, _end);
        if (res.isNotEmpty) {
          setState(() {
            _recipes.addAll(res);
          });
        } else {
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (e) {}
      setState(() {
        _isLoadMore = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_loadMore);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.green),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          title:
              Text(widget.recipe, style: const TextStyle(color: Colors.black)),
        ),
        body: _isFirstRunning
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          controller: _scrollController,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: _recipes.length,
                          itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RecipeDetail(
                                              recipe: _recipes[index]),
                                          fullscreenDialog: true));
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 5,
                                  ),
                                  child: Stack(
                                    children: [
                                      ColorFiltered(
                                        colorFilter: ColorFilter.mode(
                                            Colors.black.withOpacity(0.6),
                                            BlendMode.darken),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          child: ExtendedImage.network(
                                            _recipes[index].image1,
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
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("$index",
                                              style: const TextStyle(
                                                  fontSize: 24,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700)),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        bottom: 0,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, bottom: 10),
                                          child: Text(
                                            _recipes[index].recipeName,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                    ),
                    if (_isLoadMore == true)
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: const CircularProgressIndicator(),
                      ),
                    if (_hasNextPage == false)
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: const Text(
                          "마지막 레시피 입니다.",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                      )
                  ],
                ),
              ));
  }
}
