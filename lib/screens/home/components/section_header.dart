import 'package:flutter/material.dart';
import 'package:loja_virtual/common/common.dart';
import 'package:loja_virtual/helpers/helpers.dart';
import 'package:provider/provider.dart';
import '../../../data/data.dart';

class SectionHeader extends StatelessWidget {

  final Section section;

  SectionHeader(this.section);
  @override
  Widget build(BuildContext context) {

    final homeManager = context.watch<HomeManager>();

    if(homeManager.editing){
      return Row(
        children: [
          Expanded(
            child: TextFormField(
              initialValue: section.name,
              decoration: InputDecoration(
                hintText: R.string.title,
                isDense: true,
                border: InputBorder.none,
              ),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
              onChanged: (text) => section.name = text,
            ),
          ),
          CustomIconButton(
            iconData: Icons.remove,
            color: Colors.white,
            onTap: (){
              homeManager.removeSection(section);
            },
          ),
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          section.name ?? "" ,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      );
    }
  }
}
