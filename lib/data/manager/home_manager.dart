import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<void> saveEditing() async {
    bool valid = true;
    for (final section in _editingSections){
      if(!section.valid()) valid = false;
    }
    if(!valid) return;

    for(final section in _editingSections){
      await section.save();
    }
  }

  void discardEditing() {
    editing = false;
    notifyListeners();
  }

  void addSection(Section section) {
    _editingSections.add(section);
    notifyListeners();
  }

  void removeSection(Section section) {
    _editingSections.remove(section);
    notifyListeners();
  }
}
