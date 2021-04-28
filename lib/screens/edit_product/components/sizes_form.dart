import 'package:flutter/material.dart';
import 'package:loja_virtual/common/common.dart';
import 'package:loja_virtual/helpers/helpers.dart';
import '../../../data/data.dart';
import 'components.dart';

class SizesForm extends StatelessWidget {

  final Product product;

  SizesForm(this.product);

  @override
  Widget build(BuildContext context) {
    return FormField<List<ItemSize>>(
        initialValue: List.from(product.sizes),
      builder: (state){
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      R.string.sizes,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  CustomIconButton(
                    iconData: Icons.add,
                    color: Colors.black,
                    onTap: (){
                      //state.value -> contem a lista de tamanhos
                      state.value.add(ItemSize());
                      state.didChange(state.value);
                    },
                  ),
                ],
              ),
              Column(
                children: state.value.map((size){
                  return EditItemSize(
                    size: size,
                    onRemove: (){
                      state.value.remove(size);
                      state.didChange(state.value);
                    } ,
                  );
                }).toList(),
              ),
            ],
          );
      },
    );
  }
}
