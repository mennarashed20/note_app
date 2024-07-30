
import 'package:hive/hive.dart';
import 'package:note_app/model/note_model.dart';

class HiveHelper {
  static List<NoteModel> noteList = [];

  static void addNote(NoteModel noteModel) async {
    noteList.add(noteModel);
    await Hive.box<NoteModel>("keep_note").add(noteModel);
  }

  static void getNotes() {
    noteList = Hive.box<NoteModel>("keep_note").values.toList();
  }

  static void delectNote(int index) async {
    noteList.removeAt(index);
    await Hive.box<NoteModel>("keep_note").deleteAt(index);
  }

  static void updateNote(int index, NoteModel updatedNote) {
    noteList[index] = updatedNote;
    Hive.box<NoteModel>("keep_note").putAt(index, updatedNote);
  }

  static void delectAllNotes() {
    noteList.clear();
    Hive.box<NoteModel>("keep_note").clear();
  }
}