import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tsm/model/formdata.dart';
import 'package:tsm/network/database/database_network.dart';

class DatabaseRepo {
  final DatabaseNetwork _databaseNetwork;

  DatabaseRepo({required DatabaseNetwork databaseNetwork})
      : _databaseNetwork = databaseNetwork;

  Future<void> addData(FormData data) async {
    try {
      final jsonData = data.toJson();
      await _databaseNetwork.addData(jsonData);
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<FormData> getData() async {
    try {
      final snapshot = await _databaseNetwork.getData();

      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data() as Map<String, dynamic>;
        return FormData.fromJson(data);
      } else {
        throw Exception("No data found");
      }
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
