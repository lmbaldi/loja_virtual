import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/drawer.dart';

class BaseScreen extends StatelessWidget {

  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          drawer: CustomDrawer(),
          appBar: AppBar(
            title: const Text('Home'),
          ),
        ),
      ],
    );
  }
}
