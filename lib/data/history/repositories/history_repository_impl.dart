import '../../../core/utils/date_utils.dart';
import '../../../domain/focus/entities/focus_entity.dart';
import '../../../domain/history/repositories/history_repository.dart';
import '../../../infra/adapters/focus/focus_remote_adapter.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  const HistoryRepositoryImpl(this._adapter);

  final FocusRemoteAdapter _adapter;

  @override
  Future<List<FocusEntity>> entriesBetween(DateTime start, DateTime end) async {
    final models = await _adapter.range(
      DateUtilsX.keyOf(start),
      DateUtilsX.keyOf(end),
    );
    return models.map((m) => m.toEntity()).toList();
  }
}
