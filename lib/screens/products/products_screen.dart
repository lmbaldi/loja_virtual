import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'products.dart';
import '../../common/common.dart';
import '../../helpers/helpers.dart';
import '../../models/models.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title:  Text(R.string.products),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              showDialog(context: context, builder:  (_) => SearchDialog());
            },
          ),
        ],
      ),
      body: Consumer<ProductManager>(
        builder: (_, productManager, __){
          return ListView.builder(
            padding: const EdgeInsets.all(4),
            itemCount: productManager.allProducts.length,
            itemBuilder: (_, index){
              return ProductListTile(productManager.allProducts[index]);
            }
          );
        }
      ),
    );
  }
}
