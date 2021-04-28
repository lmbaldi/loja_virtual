import 'package:flutter/material.dart';
import '../../../helpers/helpers.dart';
import '../../../data/data.dart';

class EditItemSize extends StatelessWidget {

  final ItemSize size;

  EditItemSize({this.size});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            initialValue: size.name,
            decoration: InputDecoration(
              labelText: R.string.title,
              isDense: true,
            ),
          ),
        ),
        SizedBox(width: 4,),
        Expanded(
          child: TextFormField(
            initialValue: size.stock.toString(),
            decoration: InputDecoration(
              labelText: R.string.stock,
              isDense: true,
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        SizedBox(width: 4,),
        Expanded(
          child: TextFormField(
            initialValue: size.price.toStringAsFixed(2),
            decoration: InputDecoration(
              labelText: R.string.price,
              isDense: true,
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
        ),
      ],
    );
  }
}
