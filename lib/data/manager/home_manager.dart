import 'package:cloud_firestore/cloud_firestore.dart';
import '../data.dart';

class HomeManager {
  HomeManager() {
    _loadSections();
  }

  final Firestore firestore = Firestore.instance;
  List<Section> sections = [];

  Future<void> _loadSections() async {
    firestore.collection('home').snapshots().listen((snapshot) {
      sections.clear();
      for (final DocumentSnapshot document in snapshot.documents) {
        sections.add(Section.fromDocument(document));
      }
      print('sections  ==> $sections');
    });
  }
}
