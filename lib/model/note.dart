
import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String content;

  // Note({required this.title, required this.content});
}




// Generate the NoteAdapter for your note model class:

// add below dependencies in dev_dependencies
// dev_dependencies:
// flutter_test:
// sdk: flutter
// hive_generator: ^2.0.0
// build_runner: ^2.3.3
//
// run below code in terminal   the NoteAdapter will be created automatically
// Copy code
// flutter packages pub run build_runner build