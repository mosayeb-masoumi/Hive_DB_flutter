import 'package:hive/hive.dart';
import 'package:hive_db_example/model/note.dart';
import 'package:path_provider/path_provider.dart' as path_provider;



class NotesService {
  late Box<Note> _notesBox;

  Future<void> init() async {
    final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    Hive.registerAdapter(NoteAdapter());
    _notesBox = await Hive.openBox<Note>('notes');

  }

  List<Note> getNotes() {
     return  _notesBox.values.toList();
  }

  Future<void> addOrUpdateNote(Note note) async {
    if (note.key == null) {
      await _notesBox.add(note);
    } else {
      await note.save();
    }
  }

  Future<void> deleteNote(Note note) async {
    await note.delete();
  }
}