import 'package:get/get.dart';
import 'package:notes_app/models/NotelyModel.dart';
import 'package:notes_app/services/databaseServices.dart';

class Notescontroller extends GetxController {
  Databaseservices databaseservices = Get.find<Databaseservices>();

  var notelymodel = <Notelymodel>[].obs;

  @override
  void onInit() {
    super.onInit();
    notelymodel.bindStream(
      databaseservices.GetNotesStream().map((snapshot) {
        return snapshot.docs.map((doc) {
          return Notelymodel.fromJson(doc.data() as Map<String, dynamic>)
            ..id = doc.id;
        }).toList();
      }),
    );
  }

  //saving notes
  Future<void> addNotes(Notelymodel note) async {
    await databaseservices.addnotes(note);
  }

  //delete notes
  Future<void> deleteNotes(String id) async {
    await databaseservices.deleteNotes(id);
  }

  //update notes
  Future<void> updateNotes(Notelymodel notes) async {
    await databaseservices.updateNotes(notes);
  }
}
