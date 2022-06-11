import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:anavrin/data/models/task_model.dart';
import 'package:anavrin/data/models/note_model.dart';

class FireStoreCrud {
  FireStoreCrud();

  final _firestore = FirebaseFirestore.instance;

  Future<void> addTask({required TaskModel task}) async {
    var taskcollection = _firestore.collection('tasks');
    await taskcollection.add(task.tojson());
  }

  Stream<List<TaskModel>> getTasks({required String mydate}) {
    return _firestore
        .collection('tasks')
        .where('date', isEqualTo: mydate)
        .snapshots(includeMetadataChanges: true)
        .map((snapshor) => snapshor.docs
            .map((doc) => TaskModel.fromjson(doc.data(), doc.id))
            .toList());
  }

  Future<void> updateTask(
      {required String title,
      note,
      docid,
      date,
      starttime,
      endtime,
      required int reminder,
      colorindex}) async {
    var taskcollection = _firestore.collection('tasks');
    await taskcollection.doc(docid).update({
      'title': title,
      'note': note,
      'date': date,
      'starttime': starttime,
      'endtime': endtime,
      'reminder': reminder,
      'colorindex': colorindex,
    });
  }

  Future<void> deleteTask({required String docid}) async {
    var taskcollection = _firestore.collection('tasks');
    await taskcollection.doc(docid).delete();
  }

  Future<void> addNote({required NoteModel note}) async {
    var notecollection = _firestore.collection('notes');
    await notecollection.add(note.tojson());
  }

  Stream<List<NoteModel>> getNote() {
    return _firestore
        .collection('notes')
        .snapshots(includeMetadataChanges: true)
        .map((snapshor) => snapshor.docs
            .map((doc) => NoteModel.fromjson(doc.data(), doc.id))
            .toList());
  }

  Future<void> updateNote(
      {required String title, note, docid, colorindex}) async {
    var Notecollection = _firestore.collection('notes');
    await Notecollection.doc(docid).update({
      'title': title,
      'note': note,
      'colorindex': colorindex,
    });
  }

  Future<void> deleteNote({required String docid}) async {
    var Notecollection = _firestore.collection('notes');
    await Notecollection.doc(docid).delete();
  }
}
