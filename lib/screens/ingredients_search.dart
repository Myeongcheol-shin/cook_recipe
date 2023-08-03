import 'package:cook_recipe/models/recipe.dart';
import 'package:cook_recipe/screens/recipe_detail.dart';
import 'package:cook_recipe/services/api_service.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:lottie/lottie.dart';

class IngreditentScreen extends StatefulWidget {
  const IngreditentScreen({super.key});

  @override
  State<IngreditentScreen> createState() => _IngreditentScreenState();
}

class _IngreditentScreenState extends State<IngreditentScreen> {
  late double _distanceToField;
  late TextfieldTagsController _controller;
  Future<List<Recipe>> recipeResultList = Future.value([]);

  bool clearItem = false;
  String ingredients = "";

  @override
  void initState() {
    super.initState();
    _controller = TextfieldTagsController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
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
        ))),
        title: Text(
          !clearItem ? "재료를 통한 레시피 검색" : "검색 결과",
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.green, Colors.green.shade200],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Column(
              children: [
                TextFieldTags(
                  textfieldTagsController: _controller,
                  initialTags: const [],
                  textSeparators: const [' ', ','],
                  validator: (String tag) {
                    if (tag == 'php') {
                      return 'No, please just no';
                    } else if (_controller.getTags!.contains(tag)) {
                      return 'you already entered that';
                    }
                    return null;
                  },
                  inputfieldBuilder:
                      (context, tec, fn, error, onChanged, onSubmitted) {
                    return ((context, sc, tags, onTagDelete) {
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: TextField(
                            controller: tec,
                            focusNode: fn,
                            decoration: InputDecoration(
                              isDense: true,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 3.0,
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 3.0,
                                ),
                              ),
                              hintText:
                                  _controller.hasTags ? '' : "재료를 입력해주세요.",
                              errorText: error,
                              prefixIconConstraints: BoxConstraints(
                                  maxWidth: _distanceToField * 0.74),
                              prefixIcon: tags.isNotEmpty
                                  ? SingleChildScrollView(
                                      controller: sc,
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                          children: tags.map((String tag) {
                                        return Container(
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20.0),
                                            ),
                                            color: Colors.green,
                                          ),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                child: Text(
                                                  '#$tag',
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                onTap: () {},
                                              ),
                                              const SizedBox(width: 4.0),
                                              InkWell(
                                                child: const Icon(Icons.cancel,
                                                    size: 14.0,
                                                    color: Colors.white),
                                                onTap: () {
                                                  onTagDelete(tag);
                                                },
                                              )
                                            ],
                                          ),
                                        );
                                      }).toList()),
                                    )
                                  : null,
                            ),
                            onChanged: onChanged,
                            onSubmitted: onSubmitted,
                          ),
                        ),
                      );
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            colors: [
                              Colors.green.shade800,
                              Colors.green.shade700,
                              Colors.green.shade500
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )),
                      child: TextButton.icon(
                          onPressed: () {
                            _controller.clearTags();
                            setState(() {
                              clearItem = false;
                            });
                          },
                          icon: const Icon(Icons.cleaning_services_rounded),
                          label: const Text(
                            "CLEAR TAGS",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            colors: [
                              Colors.green.shade800,
                              Colors.green.shade700,
                              Colors.green.shade500
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )),
                      child: TextButton.icon(
                          onPressed: () {
                            setState(() {
                              clearItem = true;
                              ingredients = _controller.getTags != null
                                  ? _controller.getTags!.join(",")
                                  : "";
                            });
                            if (ingredients != "") {
                              recipeResultList =
                                  ApiService.getRecipesForIngredients(
                                      ingredients);
                            }
                          },
                          icon: const Icon(Icons.cleaning_services_rounded),
                          label: const Text(
                            "Search button",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: recipeResultList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final item = snapshot.data!;
                if (item.isEmpty) {
                  return Column(mainAxisSize: MainAxisSize.max, children: [
                    Center(
                        child: Lottie.asset('assets/lottie/result_empty.json')),
                    const Text(
                      "재료에 맞는 결과가 없습니다.",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    )
                  ]);
                }
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: item.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RecipeDetail(recipe: item[index]),
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
                                    item[index].image1,
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
                                    item[index].recipeName,
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
                      ),
                    ),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          )
        ],
      ),
    );
  }
}
