import 'package:flutter/material.dart';
import '../../../common/common.dart';
import '../../../helpers/helpers.dart';
import '../../../data/data.dart';
import 'components.dart';

class SizesForm extends StatelessWidget {

  final Product product;

  SizesForm(this.product);

  @override
  Widget build(BuildContext context) {
    return FormField<List<ItemSize>>(
      //initialValue: List.from(product.sizes),//alterada a model ItemSize
      initialValue: product.sizes,
      validator: (sizes){
        if(sizes.isEmpty)
          return R.string.enterSize;
        return null;
      },
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
                    key: ObjectKey(size),
                    size: size,
                    onRemove: (){
                      state.value.remove(size);
                      state.didChange(state.value);
                    } ,
                    onMoveUp: size != state.value.first ? (){
                      //obtem o indice da lista de tamanhos
                      final index = state.value.indexOf(size);
                      //removendo o tamanho da lista
                      state.value.remove(size);
                      //inserir o tamanho em outra posicao da lista
                      state.value.insert(index - 1, size);
                      //emite a mudanca do valor
                      state.didChange(state.value);
                    } : null,
                    onMoveDown: size != state.value.last ? (){
                      final index = state.value.indexOf(size);
                      state.value.remove(size);
                      state.value.insert(index + 1, size);
                      state.didChange(state.value);
                    } : null,
                  );
                }).toList(),
              ),
              if(state.hasError)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    state.errorText,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ),
            ],
          );
      },
    );
  }
}
