import 'package:flutter/material.dart';
import '../../../data/data.dart';

class SectionHeader extends StatelessWidget {

  final Section section;

  SectionHeader(this.section);
  @override
  Widget build(BuildContext context) {
    return Text(
      section.name,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w800,
        fontSize: 18,
      ),
    );
  }
}
