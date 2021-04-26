import 'package:cloud_firestore/cloud_firestore.dart';

import '../data.dart';

class Section {

  String name;
  String type;
  List<SectionItem> items;

  Section.fromDocument(DocumentSnapshot document){
    name = document.data['name'] as String;
    type = document.data['type'] as String;
    items = (document.data['items'] as List).map(
            (i) => SectionItem.fromMap(i)).toList();

  }

  @override
  String toString() {
    return 'Section{name: $name, type: $type, items: $items}';
  }
}