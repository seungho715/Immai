import 'package:flutter/material.dart';
//import 'welcome_page.dart';
import 'map_test.dart';

void main() {
  runApp(ImmaiApp());
}

class ImmaiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Immai',
      home: MapTest(),
    );
  }
}
