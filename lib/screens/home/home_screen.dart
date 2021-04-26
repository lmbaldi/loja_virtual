import 'package:flutter/material.dart';
import 'package:loja_virtual/common/common.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 211, 118, 130),
                    Color.fromARGB(255, 253, 181, 168),
                  ],
                  begin: Alignment.center,
                  end: Alignment.bottomCenter
              ),
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                snap: true,
                floating: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text('Loja do Baldi'),
                  centerTitle: true,
                ),
                actions: [
                  IconButton(
                      icon: Icon(Icons.shopping_cart),
                      color: Colors.white,
                      onPressed: () => Navigator.of(context).pushNamed('/cart'),
                  )
                ],
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 2000,
                  width: 200,
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}