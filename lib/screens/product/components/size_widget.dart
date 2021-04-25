import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/data.dart';

class SizeWidget extends StatelessWidget {

  final ItemSize size;

  const SizeWidget({this.size});

  @override
  Widget build(BuildContext context) {
    //watch faz o rebuild do widget inteiro
    final product = context.watch<Product>();
    final selected = size == product.selectedSize;
    Color color ;

    return GestureDetector(
      onTap: (){
        temEstoque(product);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: verificarEstoqueOuProdutoSelecionado(color, selected, context),
          )
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: verificarEstoqueOuProdutoSelecionado(color, selected, context),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                size.name,
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'R\$ ${size.price.toStringAsFixed(2)}',
                style: TextStyle(
                  color: verificarEstoqueOuProdutoSelecionado(color, selected, context),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void temEstoque(Product product) {
     if(size.hasStock){
      product.selectedSize = size;
    }
  }

  verificarEstoqueOuProdutoSelecionado(Color color, bool selected, BuildContext context) {
    if(!size.hasStock){
      color = Colors.red.withAlpha(50);
    } else if(selected){
      color = Theme.of(context).primaryColor;
    } else {
      color = Colors.grey;
    }
    return color;
  }
}
