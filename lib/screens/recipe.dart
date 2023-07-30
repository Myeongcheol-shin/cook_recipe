import 'package:flutter/material.dart';

class RecipeScreen extends StatefulWidget {
  final String recipe;

  const RecipeScreen({super.key, required this.recipe});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.green),
        title: Text(widget.recipe, style: const TextStyle(color: Colors.black)),
      ),
    );
  }
}
