import 'package:cloud_firestore/cloud_firestore.dart';
import 'OurList.dart';

class DataService {
  //
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<OurList>> loadLists() {
    return _db
        .collection('lists')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((document) => OurList.fromJson(document.data()))
        .toList());
  }

}
