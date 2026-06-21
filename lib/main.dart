import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/Controllers/NotesController.dart';
import 'package:notes_app/auth/loginScreen.dart';
import 'package:notes_app/firebase_options.dart';
import 'package:notes_app/services/databaseServices.dart';
import 'package:notes_app/theme/mytheme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(Databaseservices());
  Get.lazyPut(() => Notescontroller());
  runApp(NotesApp());
}

class NotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Loginscreen(),
      theme: mytheme,
    );
  }
}
