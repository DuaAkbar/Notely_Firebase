import 'package:get/get.dart';
import 'package:notes_app/models/NotelyModel.dart';
import 'package:notes_app/services/databaseServices.dart';

class Notescontroller extends GetxController {
  Databaseservices databaseservices = Get.find<Databaseservices>();

  var notelymodel = <Notelymodel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNotes();
  }

  //loading notes
  Future<void> loadNotes() async {
    final notes = await databaseservices.getNotes();
    notelymodel.value = notes;
  }

  //saving notes
  Future<void> addNotes(Notelymodel note) async {
    await databaseservices.insertNote(note);
    loadNotes();
  }

//delete notes
  Future<void> deleteNotes(int id) async {
    await databaseservices.deleteNotes(id);
    loadNotes();
  }

//update notes
  Future<void> updateNotes(Notelymodel notes) async {
    await databaseservices.updateNotes(notes);
    loadNotes();
  }
}
