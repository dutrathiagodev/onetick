import '../../../data/focus/models/focus_model.dart';

abstract interface class FocusRemoteAdapter {
  Future<FocusModel?> getByKey(String dateKey);

  Future<void> upsert(FocusModel model);

  /// Entries whose `dateKey` is within `[startKey, endKey]` (inclusive).
  Future<List<FocusModel>> range(String startKey, String endKey);

  Future<void> clearAll();
}
