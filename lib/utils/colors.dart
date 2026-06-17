import 'package:flutter/material.dart';

final List<String> notesColors = [
  '#FAFAFA',
  '#FFF9C4',
  '#FFF3E0',
  '#FCE4EC',
  '#FFCCBC',
  '#E3F2FD',
  '#B3E5FC',
  '#C8E6C9',
  '#E8F5E9',
  '#F3E5F5',
  '#C5CAE9',
  '#EFEBE9',
];

Color hexToColor(String hex) {
  if (hex.isEmpty) {
    return Colors.white;
  }
  return Color(int.parse(hex.substring(1), radix: 16) + 0xFF000000);
}
