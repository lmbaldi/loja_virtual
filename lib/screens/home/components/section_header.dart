import 'package:flutter/material.dart';
import '../../../data/data.dart';

class SectionHeader extends StatelessWidget {

  final Section section;

  SectionHeader(this.section);
  @override
  Widget build(BuildContext context) {
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
