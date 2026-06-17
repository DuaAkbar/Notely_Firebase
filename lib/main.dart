import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/route_manager.dart';
import 'package:notes_app/Controllers/NotesController.dart';
import 'package:notes_app/services/databaseServices.dart';
import 'package:notes_app/services/navigationService.dart';
import 'package:notes_app/theme/mytheme.dart';
import 'package:notes_app/views/HomePage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => Databaseservices().init());
  Get.put(Notescontroller());
  Get.put(Navigationservice());
  runApp(NotesApp());
}

class NotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
      theme: mytheme,
    );
  }
}
