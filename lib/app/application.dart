import 'package:flutter/material.dart';

import '../pages/home_page.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      title: 'Belajar Api',
    );
  }
}
