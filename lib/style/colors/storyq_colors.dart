import 'package:flutter/material.dart';

enum StoryqColors {
  darkPink("Dark Pink", Color(0xFFec7fa9)),
  lightPink("Light Pink", Color(0xFFffedfa)),
  mediumPink("Medium Pink", Color(0xFFffb8e0)),
  boldPink("Bold Pink", Color(0xFFbe5985)),
  darkGreen("Dark Green", Color(0xFF092635)),
  lightGreen("Light Green", Color(0xFF5c8374)),
  mediumGreen("Medium Green", Color(0xFF1b4242)),
  softGreen("Soft Green", Color(0xFF9ec8b9)),
  red("Red", Colors.redAccent),
  white("White", Colors.white),
  black("Black", Colors.black);

  const StoryqColors(this.name, this.color);

  final String name;
  final Color color;
}
