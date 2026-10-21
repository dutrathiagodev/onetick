import '../../../data/focus/models/focus_model.dart';
import 'focus_remote_adapter.dart';

class InMemoryFocusAdapter implements FocusRemoteAdapter {
  InMemoryFocusAdapter([Iterable<FocusModel> seed = const []]) {
    for (final m in seed) {
      _store[m.dateKey] = m;
    }
  }

  final Map<String, FocusModel> _store = {};

  @override
  Future<FocusModel?> getByKey(String dateKey) async => _store[dateKey];

  @override
  Future<void> upsert(FocusModel model) async => _store[model.dateKey] = model;

  @override
  Future<List<FocusModel>> range(String startKey, String endKey) async {
    return _store.values
        .where(
          (m) =>
              m.dateKey.compareTo(startKey) >= 0 &&
              m.dateKey.compareTo(endKey) <= 0,
        )
        .toList();
  }

  @override
  Future<void> clearAll() async => _store.clear();
}
