import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:notes_app/Controllers/NotesController.dart';
import 'package:notes_app/models/NotelyModel.dart';
import 'package:notes_app/utils/colors.dart';
import 'package:notes_app/views/EditScreen.dart';

class NotesScreen extends StatefulWidget {
  final Notelymodel note;
  const NotesScreen({super.key, required this.note});

  @override
  State<StatefulWidget> createState() => NotesScreenState();
}

class NotesScreenState extends State<NotesScreen> {
  Notescontroller notescontroller = Get.find<Notescontroller>();
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: hexToColor(widget.note.color),
      appBar: AppBar(
        title: Text(
          widget.note.title,
          style: TextStyle(
            color: colors.onSurface,
            fontFamily: 'Nunito',
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.off(()=>Editscreen(note: widget.note));
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.note.date,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w600,
                  color: colors.primary,
                ),
              ),
              SizedBox(height: 8),
              Container(height: 3, width: 50, color: colors.primary),
              SizedBox(height: 16),
              Text(
                widget.note.preview,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
