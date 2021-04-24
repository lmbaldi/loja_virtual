import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:provider/provider.dart';

import '../../helpers/helpers.dart';
import '../../models/models.dart';
import '../screens.dart';

class ProductScreen extends StatelessWidget {

  final Product product;

  ProductScreen(this.product);

  @override
  Widget build(BuildContext context) {

    final primaryColor = Theme.of(context).primaryColor;

    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        appBar: AppBar(
          title: Text(product.name),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: ListView(
         children: [
           AspectRatio(
             aspectRatio: 1.2,
             child: Carousel(
               images: product.images.map((url) {
                 return NetworkImage(url);
               }).toList(),
               dotSize: 4,
               dotSpacing: 15,
               dotBgColor: Colors.transparent,
               dotColor: primaryColor,
               autoplay: false,
             ),
           ),
           Padding(
             padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  product.name,
                  style: TextStyle(
                      fontSize:  20,
                      fontWeight: FontWeight.w600
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      R.string.from,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Text(
                    'R\$ 19.99',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: primaryColor
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(top:  16, bottom: 8),
                  child: Text(
                    R.string.description,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  product.description,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 8),
                  child: Text(
                    R.string.sizes,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: product.sizes.map((s) {
                    return SizeWidget(size: s);
                  }).toList(),
                ),
                const SizedBox(height: 20),
                //botao depende de dois estados:usario logado e valor selecionado
                //O consumer faz o rebuild apenas uma parte do widget
                if(product.hasStock)
                Consumer2<UserManager, Product>(
                    builder: (_, userManager, product, __){
                      return SizedBox(
                        height: 44,
                        child: RaisedButton(
                          color: primaryColor,
                          textColor: Colors.white,
                          child: Text(
                            userManager.isLoggedIn
                            ? R.string.addToCart
                            : R.string.signInToBuy,
                            style: TextStyle(fontSize: 18),
                          ),
                          onPressed: product.selectedSize != null
                          ? (){
                              if(userManager.isLoggedIn){
                                //TODO ADICIONAR AO CARRINHO
                              } else {
                                Navigator.of(context).pushNamed('/login');
                              }
                            }
                          : null,
                        ),
                      );
                    }
                ),
              ],
            ),
           )
         ],
        ),
      ),
    );
  }
}
