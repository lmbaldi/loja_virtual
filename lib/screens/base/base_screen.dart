import 'package:flutter/material.dart';
import 'package:loja_virtual/helpers/helpers.dart';
import 'package:loja_virtual/screens/admin_users/admin_users_screen.dart';
import 'package:provider/provider.dart';
import '../../data/data.dart';
import '../products/products.dart';
import '../screens.dart';
import '../helpers/helpers.dart';
import '../../common/common.dart';

class BaseScreen extends StatelessWidget {

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {

    return Provider(
      create: (_) => PageManager(pageController),
      child: Consumer<UserManager>(
        builder:(_, userManager, __){
          return PageView(
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
              Scaffold(
                drawer: CustomDrawer(),
                appBar: AppBar(
                  title: const  Text('Home 2'),
                ),
              ),
              if(userManager.adminEnabled)
                ...[
                  AdminUsersScreen(),
                  Scaffold(
                    drawer: CustomDrawer(),
                    appBar: AppBar(
                      title: Text(R.string.orders),
                    ),
                  ),
                ]
            ],
          );
        },
      ),
    );
  }
}
