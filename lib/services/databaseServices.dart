import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:notes_app/models/NotelyModel.dart';

class Databaseservices extends GetxService {
  String get currentUid => FirebaseAuth.instance.currentUser!.uid;
  final CollectionReference notelyCollects = FirebaseFirestore.instance
      .collection('notes');

  //add notes
  Future<void> addnotes(Notelymodel note) {
    return notelyCollects.add(note.toJson());
  }

  //get notes
  Stream<QuerySnapshot> GetNotesStream() {
    final notelyscreen =
        notelyCollects.where('uid', isEqualTo: currentUid).snapshots();
    return notelyscreen;
  }

  //update notes
  Future<void> updateNotes(Notelymodel note) {
    return notelyCollects.doc(note.id).update(note.toJson());
  }

  //delete notes
  Future<void> deleteNotes(String id) {
    return notelyCollects.doc(id).delete();
  }
}
