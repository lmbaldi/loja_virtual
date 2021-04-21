import 'package:flutter/material.dart';
import 'package:loja_virtual/common/common.dart';
import 'package:provider/provider.dart';
import '../screens.dart';
import '../helpers/helpers.dart';

class BaseScreen extends StatelessWidget {

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const  Text('Home'),
            ),
          ),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const  Text('Home1'),
            ),
          ),
        ],
      ),
    );
  }
}
