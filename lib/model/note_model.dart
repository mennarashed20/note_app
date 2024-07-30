import 'package:hive_flutter/hive_flutter.dart';
part 'note_model.g.dart';
@HiveType(typeId: 0)
class NoteModel {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String note;
  @HiveField(2)
  final String date;
  @HiveField(3)
  final  DateTime modifiedTime;


  NoteModel({required this.title, required this.note, required this.date,required this.modifiedTime});

  factory NoteModel.formjson(Map<String, String> json) {
    return NoteModel(
      title: json['title'] as String,
      note: json['note'] as String,
      date: json['date'] as String,
      modifiedTime:json['modifiedTime'] as DateTime,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'note': note,
      'date': date,
      'modifiedTime': modifiedTime,
    };
  }
}

//