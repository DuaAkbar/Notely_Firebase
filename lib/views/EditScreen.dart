import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:notes_app/Controllers/NotesController.dart';
import 'package:notes_app/models/NotelyModel.dart';
import 'package:notes_app/utils/colors.dart';
import 'package:notes_app/views/NotesScreen.dart';

class Editscreen extends StatefulWidget {
  final Notelymodel note;
  const Editscreen({super.key, required this.note});

  @override
  State<Editscreen> createState() => _EditscreenState();
}

class _EditscreenState extends State<Editscreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController previewController = TextEditingController();

  String selectedColor = '';

  Notescontroller notescontroller = Get.find<Notescontroller>();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.note.title;
    previewController.text = widget.note.preview;
    selectedColor = widget.note.color;
  }

  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: hexToColor(selectedColor),
      appBar: AppBar(
        title: Text(
          "Edit Your Notes!",
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
                            selectedColor = color;
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
                                selectedColor == color
                                    ? Border.all(
                                      width: 1,
                                      color: Colors.black87,
                                    )
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
        onPressed: () {
          widget.note.title = titleController.text.trim();
          widget.note.preview = previewController.text.trim();
          widget.note.color = selectedColor;

          notescontroller.updateNotes(widget.note);
          Get.off(NotesScreen(note: widget.note));
        },

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Icon(Icons.check),
      ),
    );
  }
}
