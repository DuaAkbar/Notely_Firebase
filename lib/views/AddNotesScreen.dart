import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:notes_app/Controllers/NotesController.dart';
import 'package:notes_app/models/NotelyModel.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/utils/colors.dart';

class AddNotesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddNotesScreenState();
}

class AddNotesScreenState extends State<AddNotesScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController previewController = TextEditingController();

  Notescontroller notescontroller = Get.find<Notescontroller>();

  String selectedColors = notesColors[0];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: hexToColor(selectedColors),
      appBar: AppBar(
        title: Text(
          "Add Your Notes!",
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: colors.primary,
          ),
        ),
      ),

      body: Column(
        children: [
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: TextField(
              controller: titleController,
              minLines: 1,
              maxLines: 2,
              maxLength: 50,
              decoration: InputDecoration(
                label: Text(
                  "Title!",
                  style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: colors.secondary, width: 1.0),
                ),
              ),
            ),
          ),

          SizedBox(height: 5),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: TextField(
              controller: previewController,
              minLines: 1,
              maxLines: 5,
              maxLength: 500,
              decoration: InputDecoration(
                label: Text(
                  "Write your Note!",
                  style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: colors.secondary, width: 1.0),
                ),
              ),
            ),
          ),

          SizedBox(height: 15),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:
                  notesColors.map((color) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColors = color;
                        });
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: hexToColor(color),
                          border:
                              selectedColors == color
                                  ? Border.all(width: 1, color: Colors.black87)
                                  : Border.all(width: 1, color: Colors.grey),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String title = titleController.text.trim();
          String preview = previewController.text.trim();
          String date = DateFormat('dd MMM yyyy').format(DateTime.now());

          if (title.isNotEmpty && preview.isNotEmpty) {
            try {
              await notescontroller.addNotes(
                Notelymodel(
                  uid: FirebaseAuth.instance.currentUser!.uid,
                  title: title,
                  preview: preview,
                  date: date,
                  color: selectedColors,
                ),
              );
              Get.back();
            } catch (e) {
              Get.snackbar("Error", e.toString());
            }
          } else {
            Get.snackbar('Error', "Please Provide Tiltle and Notes both");
          }
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Icon(Icons.check),
      ),
    );
  }
}
