import 'package:flutter/material.dart';
import 'package:hive_db_example/home_page.dart';

import 'package:hive/hive.dart';
import 'package:hive_db_example/model/note.dart';
import 'package:hive_db_example/note_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  // Hive.init(appDocumentDirectory.path);
  // Hive.registerAdapter(NoteAdapter());
  // await Hive.openBox<Note>('notes');
  // _notesService.init();

  // final _notesService = NotesService();
  // _notesService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}


