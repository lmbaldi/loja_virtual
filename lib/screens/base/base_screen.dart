import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/products/products.dart';
import 'package:loja_virtual/screens/screens.dart';
import 'package:provider/provider.dart';
import '../helpers/helpers.dart';
import '../../common/common.dart';

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
         HomeScreen(),
          ProductsScreen(),
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
