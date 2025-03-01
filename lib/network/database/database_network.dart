import 'package:cloud_firestore/cloud_firestore.dart';

const String usersCollection = "users";

class DatabaseNetwork {
  late final FirebaseFirestore _firestoreInstance;
  late final String _userId;
  late final CollectionReference _usersCollection;

  DatabaseNetwork(
      {required FirebaseFirestore firestoreInstance, required String userId}) {
    _firestoreInstance = firestoreInstance;
    _userId = userId;
    _usersCollection = _firestoreInstance
        .collection(usersCollection)
        .doc(_userId)
        .collection("UserData");
  }

  Future<void> addData(Map<String, dynamic> data) async {
    try {
      await _usersCollection.add(data);
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<QuerySnapshot<Object?>> getData() async {
    try {
      return await _usersCollection.snapshots().first;
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e);
    }
  }
}
