import 'package:flutter/material.dart';
import '../../../common/common.dart';
import '../../../helpers/helpers.dart';
import '../../../data/data.dart';

class EditItemSize extends StatelessWidget {
  final ItemSize size;
  final VoidCallback onRemove;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;

  EditItemSize(
      {Key key, this.size, this.onRemove, this.onMoveUp, this.onMoveDown})
      : super(key: key);
  //key para identificar o widget
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size.name,
            decoration: InputDecoration(
              labelText: R.string.title,
              isDense: true,
            ),
            validator: (name){
              if(name.isEmpty){
                return R.string.invalidField;
              }
              return null;
            },
            onChanged: (name) => size.name = name,
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size.stock?.toString(),
            decoration: InputDecoration(
              labelText: R.string.stock,
              isDense: true,
            ),
            keyboardType: TextInputType.number,
            validator: (stock){
              if(int.tryParse(stock) == null)
                return R.string.invalidField;
              return null;
            },
            onChanged: (stock) => size.stock = int.tryParse(stock),
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
          flex: 40,
          child: TextFormField(
            initialValue: size.price?.toStringAsFixed(2),
            decoration: InputDecoration(
                labelText: R.string.price,
                isDense: true,
                prefixText: R.string.prefixText),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            validator: (price){
              if(num.tryParse(price) == null)
                return R.string.invalidField;
              return null;
            },
            onChanged: (price) => size.price = num.tryParse(price),
          ),
        ),
        CustomIconButton(
          iconData: Icons.remove,
          color: Colors.red,
          onTap: onRemove,
        ),
        CustomIconButton(
          iconData: Icons.arrow_drop_up,
          color: Colors.black,
          onTap: onMoveUp,
        ),
        CustomIconButton(
          iconData: Icons.arrow_drop_down,
          color: Colors.black,
          onTap: onMoveDown,
        ),
      ],
    );
  }
}
