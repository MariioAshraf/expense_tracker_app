abstract class StoreService {
  Future<void> addData({
    required Map<String, dynamic> data,
    required String docId,
    required String collectionName,
  });
}
