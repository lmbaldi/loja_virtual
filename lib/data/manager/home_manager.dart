import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../data.dart';

class HomeManager extends ChangeNotifier{
  HomeManager() {
    _loadSections();
  }

  final Firestore firestore = Firestore.instance;
  List<Section> _sections = [];
  List<Section> _editingSections = [];

  bool editing = false;

  Future<void> _loadSections() async {
    firestore.collection('home').snapshots().listen((snapshot) {
      _sections.clear();
      for (final DocumentSnapshot document in snapshot.documents) {
        _sections.add(Section.fromDocument(document));
      }
      notifyListeners();
    });
  }

  List<Section> get sections {
    if(editing){
      return _editingSections;
    }
    return _sections;
  }

  void enterEditing(){
    editing = true;
    _editingSections = _sections.map((s) => s.clone()).toList();
    notifyListeners();
  }

  void saveEditing() {
    editing = false;
    notifyListeners();
  }

  void discardEditing() {
    editing = false;
    notifyListeners();
  }

  void addSection(Section section) {
    _editingSections.add(section);
    notifyListeners();
  }
}
