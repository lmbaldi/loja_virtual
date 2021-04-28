import 'package:flutter/material.dart';
import '../../../data/data.dart';
import 'components.dart';

class SizesForm extends StatelessWidget {

  final Product product;

  SizesForm(this.product);

  @override
  Widget build(BuildContext context) {
    return FormField<List<ItemSize>>(
        initialValue: product.sizes,
      builder: (state){
          return Column(
            children: state.value.map((size){
              return EditItemSize(
                size: size,
              );
            }).toList(),
          );
      },
    );
  }
}
