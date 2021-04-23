import 'package:flutter/material.dart';
import 'package:loja_virtual/helpers/helpers.dart';
import 'package:loja_virtual/models/models.dart';

class ProductListTile extends StatelessWidget {

  final Product product;

  const ProductListTile(this.product);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed('/product', arguments: product);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(product.images.first),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Expanded(child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 4) ,
                        child: Text(
                          R.string.from,
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize:  14
                          ),
                        ),
                    ),
                    Text(
                      'R\$ 19.99',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  ],
                ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
