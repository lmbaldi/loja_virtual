import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../data.dart';

class Section extends ChangeNotifier {

  String name;
  String type;
  List<SectionItem> items;


  Section({this.name, this.type, this.items}){
   items = items ?? [];
  }

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

  Section clone() {
    return Section(
      name: name,
      type: type,
      items: items.map((e) => e.clone()).toList(),
    );
  }

  void addItem(SectionItem item) {
    items.add(item);
    notifyListeners();
  }


}