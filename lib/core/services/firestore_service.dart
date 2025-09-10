import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_app/core/services/store_service.dart';

class FirestoreService implements StoreService {
  @override
  Future<void> addData({
    required Map<String, dynamic> data,
    required String docId,
    required String collectionName,
  }) async {
    final usersCollection =
        FirebaseFirestore.instance.collection(collectionName);
    final doc = usersCollection.doc(docId);
    await doc.set(data);
  }
}
