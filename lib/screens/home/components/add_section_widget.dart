import 'package:flutter/material.dart';
import '../../../data/data.dart';
import '../../../helpers/helpers.dart';

class AddSectionWidget extends StatelessWidget {

  final HomeManager homeManager;

  AddSectionWidget(this.homeManager);

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Expanded(
          child: FlatButton(
            onPressed: (){
              homeManager.addSection(Section(type: 'List'));
            },
            textColor: Colors.white,
            child: Text(R.string.addList),
          ),
        ),
        Expanded(
            child: FlatButton(
              onPressed: (){
                homeManager.addSection(Section(type: 'Staggered'));
              },
              textColor: Colors.white,
              child: Text(R.string.addGrid),
            ),
          )
      ],
    );
  }
}
