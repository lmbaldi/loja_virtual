import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/data.dart';
import 'products.dart';
import '../../common/common.dart';
import '../../helpers/helpers.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Consumer<ProductManager>(
          builder: (_, productManager, __){
            if(productManager.search.isEmpty){
              return  Text(R.string.products);
            } else {
              return LayoutBuilder(
                builder: (_, constraints){

                  return GestureDetector(
                    onTap: () async {
                      final search =  await showDialog<String>(
                          context: context,
                          builder:  (_) => SearchDialog(productManager.search),
                      );
                      if (search != null){
                        productManager.search = search;
                      }
                    },
                    child: Container(
                      width: constraints.biggest.width,
                        child: Text(
                            productManager.search,
                            textAlign: TextAlign.center,
                        ),
                    ),
                  );
                },
              );
            }
          },
        ),
        centerTitle: true,
        actions: [
          Consumer<ProductManager>(
            builder: (_, productManager, __){
              if(productManager.search.isEmpty){
                return IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    final search =  await showDialog<String>(context: context, builder:  (_) => SearchDialog(productManager.search));
                    if (search != null){
                      productManager.search = search;
                    }
                  },
                );
              } else {
                return IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () async {
                    productManager.search = '';
                  },
                );
              }
            },
          ),
          Consumer<UserManager>(
            builder: (_, userManager, __){
              if(userManager.adminEnabled){
                return IconButton(
                  icon: Icon(Icons.add),
                  onPressed: (){
                    Navigator.of(context).pushNamed(
                      '/edit_product',
                    );
                  },
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
      body: Consumer<ProductManager>(
        builder: (_, productManager, __){
          final filteredProducts = productManager.filteredProducts;
          return ListView.builder(
            itemCount: filteredProducts.length,
            itemBuilder: (_, index){
              return ProductListTile(filteredProducts[index]);
            }
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor:  Theme.of(context).primaryColor,
        onPressed: (){
          Navigator.of(context).pushNamed('/cart');
        },
        child: Icon(Icons.add_shopping_cart),
      ),
    );
  }
}
