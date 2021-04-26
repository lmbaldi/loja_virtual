import 'package:flutter/material.dart';
import '../../../data/data.dart';
import 'component.dart';

class SectionList extends StatelessWidget {

  final Section section;
  SectionList(this.section);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(section),
        ],
      ),
    );
  }
}
