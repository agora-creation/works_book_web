import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:works_book_web/models/group.dart';

class GroupService {
  String collection = 'group';
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String id() {
    return firestore.collection(collection).doc().id;
  }

  void create(Map<String, dynamic> values) {
    firestore.collection(collection).doc(values['id']).set(values);
  }

  void update(Map<String, dynamic> values) {
    firestore.collection(collection).doc(values['id']).update(values);
  }

  Future<GroupModel?> select(String? number) async {
    GroupModel? ret;
    await firestore
        .collection(collection)
        .where('number', isEqualTo: number ?? 'error')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        ret = GroupModel.fromSnapshot(value.docs.first);
      }
    });
    return ret;
  }

  Future<List<GroupModel>> selectList() async {
    List<GroupModel> ret = [];
    await firestore.collection(collection).get().then((value) {
      for (DocumentSnapshot<Map<String, dynamic>> doc in value.docs) {
        ret.add(GroupModel.fromSnapshot(doc));
      }
    });
    return ret;
  }
}
