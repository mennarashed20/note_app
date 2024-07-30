// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:note_app/constants/colors.dart';
// import 'package:note_app/hive_helper.dart';
// import 'package:note_app/model.dart';
// import 'package:note_app/model/note_model.dart';
// //import 'package:note_app/models/note.dart';
// import 'package:note_app/screens/edit.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
//   bool sorted = false;
//
//   @override
//   // void initState() {
//   //   super.initState();
//   //  // filteredNotes = sampleNotes;
//   //   HiveHelper.getNotes();
//   // }
//
//   List<NoteModel> sortNotesByModifiedTime(List<NoteModel> notes) {
//     if (sorted) {
//       notes.sort((a, b) => a.modifiedTime.compareTo(b.modifiedTime));
//     } else {
//       notes.sort((b, a) => a.modifiedTime.compareTo(b.modifiedTime));
//     }
//
//     sorted = !sorted;
//
//     return notes;
//   }
//
//   getRandomColor() {
//     Random random = Random();
//     return backgroundColors[random.nextInt(backgroundColors.length)];
//   }
//     List<NoteModel> filteredNotes=[];
//   void onSearchTextChanged(String searchText) {
//     setState(() {
//       filteredNotes = HiveHelper.noteList
//           .where((note) =>
//       note.note.toLowerCase().contains(searchText.toLowerCase()) ||
//           note.title.toLowerCase().contains(searchText.toLowerCase()))
//           .toList();
//     });
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade900,
//       body: Padding(
//         padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Notes',
//                   style: TextStyle(fontSize: 30, color: Colors.white),
//                 ),
//                 IconButton(
//                     onPressed: () {
//                       setState(() {
//                         filteredNotes = sortNotesByModifiedTime(filteredNotes);
//                       });
//                     },
//                     padding: const EdgeInsets.all(0),
//                     icon: Container(
//                       width: 40,
//                       height: 40,
//                       decoration: BoxDecoration(
//                           color: Colors.grey.shade800.withOpacity(.8),
//                           borderRadius: BorderRadius.circular(10)),
//                       child: const Icon(
//                         Icons.sort,
//                         color: Colors.white,
//                       ),
//                     ))
//               ],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             TextField(
//               onChanged: onSearchTextChanged,
//               style: const TextStyle(fontSize: 16, color: Colors.white),
//               decoration: InputDecoration(
//                 contentPadding: const EdgeInsets.symmetric(vertical: 12),
//                 hintText: "Search notes...",
//                 hintStyle: const TextStyle(color: Colors.grey),
//                 prefixIcon: const Icon(
//                   Icons.search,
//                   color: Colors.grey,
//                 ),
//                 fillColor: Colors.grey.shade800,
//                 filled: true,
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: const BorderSide(color: Colors.transparent),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: const BorderSide(color: Colors.transparent),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20,),
//             Expanded(
//                 child: ListView.builder(
//                   padding: const EdgeInsets.only(top: 30),
//                   itemCount: HiveHelper.noteList.length,
//                   itemBuilder: (context, index) {
//                     return Card(
//                       margin: const EdgeInsets.only(bottom: 20),
//                       color: getRandomColor(),
//                       elevation: 3,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10)),
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: ListTile(
//                           onTap: () async {
//                             final result = await Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (BuildContext context) =>
//                                     EditScreen(note: HiveHelper.noteList[index]),
//                               ),
//                             );
//                             if (result != null) {
//                               setState(() {
//                                 int originalIndex =
//                                 HiveHelper.noteList.indexOf(HiveHelper.noteList[index]);
//
//                                 HiveHelper.noteList[originalIndex] = NoteModel(
//
//                                     title: result[0],
//                                     note: result[1],
//                                     date: gettingDayDate(),
//                                     modifiedTime: DateTime.now());
//
//                                 HiveHelper.noteList[index] = NoteModel(
//
//                                     title: result[0],
//                                     note: result[1],
//                                     date: gettingDayDate(),
//                                     modifiedTime: DateTime.now());
//                               });
//                             }
//                           },
//                           title: RichText(
//                             maxLines: 3,
//                             overflow: TextOverflow.ellipsis,
//                             text: TextSpan(
//                                 text: '${filteredNotes[index].title} \n',
//                                 style: const TextStyle(
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 18,
//                                     height: 1.5),
//                                 children: [
//                                   TextSpan(
//                                     text: HiveHelper.noteList[index].note,
//                                     style: const TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.normal,
//                                         fontSize: 14,
//                                         height: 1.5),
//                                   )
//                                 ]),
//                           ),
//                           subtitle: Padding(
//                             padding: const EdgeInsets.only(top: 8.0),
//                             child: Text(
//                               'Edited: ${DateFormat('EEE MMM d, yyyy h:mm a').format(HiveHelper.noteList[index].modifiedTime)}',
//                               style: TextStyle(
//                                   fontSize: 10,
//                                   fontStyle: FontStyle.italic,
//                                   color: Colors.grey.shade800),
//                             ),
//                           ),
//                           trailing: IconButton(
//                             onPressed: () async {
//                               final result = await confirmDialog(context);
//                               if (result != null && result) {
//                                 HiveHelper.delectNote(index);
//                                   setState(() {
//
//                                   });
//                               }
//                             },
//                             icon: const Icon(
//                               Icons.delete,
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ))
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final result = await Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (BuildContext context) => const EditScreen(),
//             ),
//           );
//
//           if (result != null) {
//             setState(() {
//               // HiveHelper.noteList.add((
//               //   // id: HiveHelper.noteList.length,
//               //    title: result[0],
//               //     content: result[1],
//               //     mdifiedTime: DateTime.now()));
//               NoteModel note=NoteModel(title: result[0], note: result[1], date:  gettingDayDate(),  modifiedTime: DateTime.now());
//               HiveHelper.addNote(note);
//               filteredNotes = HiveHelper.noteList;
//             });
//           }
//         },
//         elevation: 10,
//         backgroundColor: Colors.grey.shade800,
//         child: const Icon(
//           Icons.add,
//           size: 38,
//         ),
//       ),
//     );
//   }
//
//   Future<dynamic> confirmDialog(BuildContext context) {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             backgroundColor: Colors.grey.shade900,
//             icon: const Icon(
//               Icons.info,
//               color: Colors.grey,
//             ),
//             title: const Text(
//               'Are you sure you want to delete?',
//               style: TextStyle(color: Colors.white),
//             ),
//             content: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   ElevatedButton(
//                       onPressed: () {
//                         Navigator.pop(context, true);
//                       },
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.green),
//                       child: const SizedBox(
//                         width: 60,
//                         child: Text(
//                           'Yes',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       )),
//                   ElevatedButton(
//                       onPressed: () {
//                         Navigator.pop(context, false);
//                       },
//                       style:
//                       ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                       child: const SizedBox(
//                         width: 60,
//                         child: Text(
//                           'No',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       )),
//                 ]),
//           );
//         });
//   }
// }
//
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/constants/colors.dart';
import 'package:note_app/hive_helper.dart';
import 'package:note_app/model.dart';
import 'package:note_app/model/note_model.dart';
//import 'package:note_app/models/note.dart';
import 'package:note_app/screens/edit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool sorted = false;
  List<NoteModel> filteredNotes = HiveHelper.noteList;

  @override
  void initState() {
    super.initState();
    filteredNotes = HiveHelper.noteList;
  }

  List<NoteModel> sortNotesByModifiedTime(List<NoteModel> notes) {
    if (sorted) {
      notes.sort((a, b) => a.modifiedTime.compareTo(b.modifiedTime));
    } else {
      notes.sort((b, a) => a.modifiedTime.compareTo(b.modifiedTime));
    }

    sorted = !sorted;

    return notes;
  }

  getRandomColor() {
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }

  void onSearchTextChanged(String searchText) {
    setState(() {
      filteredNotes = HiveHelper.noteList
          .where((note) =>
      note.note.toLowerCase().contains(searchText.toLowerCase()) ||
          note.title.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Keep Notes',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        filteredNotes = sortNotesByModifiedTime(filteredNotes);
                      });
                    },
                    padding: const EdgeInsets.all(0),
                    icon: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade800.withOpacity(.8),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(
                        Icons.sort,
                        color: Colors.white,
                      ),
                    ))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: onSearchTextChanged,
              style: const TextStyle(fontSize: 16, color: Colors.white),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                hintText: "Search your notes...",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                fillColor: Colors.grey.shade800,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 30),
                itemCount: filteredNotes.length,
                itemBuilder: (context, index) {
                  if (index >= filteredNotes.length) {
                    return Container(); // تأكد من أن العنصر متاح قبل المحاولة للوصول إليه
                  }
                  return Card(
                    margin: const EdgeInsets.only(bottom: 20),
                    color: getRandomColor(),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  EditScreen(note: filteredNotes[index]),
                            ),
                          );
                          if (result != null) {
                            setState(() {
                              int originalIndex = HiveHelper.noteList
                                  .indexOf(filteredNotes[index]);

                              HiveHelper.noteList[originalIndex] = NoteModel(
                                  title: result[0],
                                  note: result[1],
                                  date: gettingDayDate(),
                                  modifiedTime: DateTime.now());

                              filteredNotes[originalIndex] = NoteModel(
                                  title: result[0],
                                  note: result[1],
                                  date: gettingDayDate(),
                                  modifiedTime: DateTime.now());
                            });
                          }
                        },
                        title: RichText(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              text: '${filteredNotes[index].title} \n',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  height: 1.5),
                              children: [
                                TextSpan(
                                  text: filteredNotes[index].note,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                      height: 1.5),
                                )
                              ]),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Edited: ${DateFormat('EEE MMM d, yyyy h:mm a').format(filteredNotes[index].modifiedTime)}',
                            style: TextStyle(
                                fontSize: 10,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey.shade800),
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () async {
                            final result = await confirmDialog(context);
                            if (result != null && result) {
                              HiveHelper.delectNote(index);
                              setState(() {
                                filteredNotes = HiveHelper.noteList;
                              });
                            }
                          },
                          icon: const Icon(
                            Icons.delete,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const EditScreen(),
            ),
          );

          if (result != null) {
            setState(() {
              NoteModel note = NoteModel(
                  title: result[0],
                  note: result[1],
                  date: gettingDayDate(),
                  modifiedTime: DateTime.now());
              HiveHelper.addNote(note);
              filteredNotes = HiveHelper.noteList;
            });
          }
        },
        elevation: 10,
        backgroundColor: Colors.grey.shade800,
        child: const Icon(
          Icons.add,
          size: 38,
        ),
      ),
    );
  }

  Future<dynamic> confirmDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade900,
            icon: const Icon(
              Icons.info,
              color: Colors.grey,
            ),
            title: const Text(
              'Are you sure you want to delete?',
              style: TextStyle(color: Colors.white),
            ),
            content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      child: const SizedBox(
                        width: 60,
                        child: Text(
                          'Yes',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const SizedBox(
                        width: 60,
                        child: Text(
                          'No',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ]),
          );
        });
  }
}
