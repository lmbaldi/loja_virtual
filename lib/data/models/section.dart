import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../helpers/helpers.dart';

import '../data.dart';

class Section extends ChangeNotifier {

  String id;
  String name;
  String type;
  List<SectionItem> items;
  List<SectionItem> originalItems;

  Section({this.id, this.name, this.type, this.items}){
    //lista apos a modificacao
    items = items ?? [];
   //lista nova que contem secao antes da modificao
   originalItems = List.from(items);
  }

  Section.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    name = document.data['name'] as String;
    type = document.data['type'] as String;
    items = (document.data['items'] as List).map(
            (i) => SectionItem.fromMap(i)).toList();
  }

  final Firestore firestore = Firestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  DocumentReference get firestoreRef => firestore.document('home/$id');
  StorageReference get storageRef => storage.ref().child('home').child(id);

  String _error;

  String get error => _error;

  set error(String value){
    _error = value;
    notifyListeners();
  }

  Section clone() {
    return Section(
      id: id,
      name: name,
      type: type,
      items: items.map((e) => e.clone()).toList(),
    );
  }

  void addItem(SectionItem item) {
    items.add(item);
    notifyListeners();
  }

  void removeItem(SectionItem item) {
    items.remove(item);
    notifyListeners();
  }

  bool valid(){
    if(name == null || name.isEmpty){
      error = R.string.invalidTitle;
    } else if (items.isEmpty){
      error = R.string.isEmptyImage;
    } else {
      error = null;
    }
    return error == null;
  }

  Future<void> save(int pos) async {
    final Map<String, dynamic> data = {
      'name': name,
      'type': type,
      'pos': pos,
    };

    if(id == null){
      final doc = await firestore.collection('home').add(data);
      id = doc.documentID;
    } else {
      await firestoreRef.updateData(data);
    }

    for(final item in items){
      if(item.image is File){
        final StorageUploadTask task = storageRef.child(Uuid().v1()).putFile(item.image as File);
        final StorageTaskSnapshot snapshot = await task.onComplete;
        final String url = await snapshot.ref.getDownloadURL() as String;
        item.image = url;
      }
    }

    for(final original in originalItems){
      //correcao de bug, no iOS ocorre um erro com as imagens, para diferenciar a origem do firebase e da internet
      if(!items.contains(original) && (original.image as String).contains('firebase')){
        try {
          final ref = await storage.getReferenceFromUrl(
              original.image as String);
          await ref.delete();
        }catch (e) {}
      }
    }

    final Map<String, dynamic> itemsData = {
      'items': items.map((e) => e.toMap()).toList()
    };

    await firestoreRef.updateData(itemsData);
  }

  Future<void> delete() async {
    await firestoreRef.delete();
    for(final item in items ){
      //correcao de bug, no iOS ocorre um erro com as imagens, para diferenciar a origem do firebase e da internet
      if((item.image as String).contains('firebase')){
        try {
          final ref = await storage.getReferenceFromUrl(item.image as String);
          await ref.delete();
        } catch (e){}
      }
    }
  }

  @override
  String toString() {
    return 'Section{name: $name, type: $type, items: $items}';
  }

}


















