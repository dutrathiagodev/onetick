import '../../../core/utils/date_utils.dart';
import '../../../domain/focus/entities/focus_entity.dart';
import '../../../domain/focus/repositories/focus_repository.dart';
import '../../../core/failures.dart';
import '../../../infra/adapters/focus/focus_remote_adapter.dart';
import '../models/focus_model.dart';

class FocusRepositoryImpl implements FocusRepository {
  const FocusRepositoryImpl(this._adapter, this._now);

  final FocusRemoteAdapter _adapter;
  final DateTime Function() _now;

  @override
  Future<FocusEntity?> getToday() async {
    final model = await _adapter.getByKey(DateUtilsX.keyOf(_now()));
    return model?.toEntity();
  }

  @override
  Future<FocusEntity> saveToday(String title) async {
    final key = DateUtilsX.keyOf(_now());
    final existing = await _adapter.getByKey(key);
    // Keep completion when the user only re-saves the same text.
    final keepCompletion =
        existing != null && existing.title == title && existing.completed;
    final model = FocusModel(
      dateKey: key,
      title: title,
      completed: keepCompletion,
      completedAt: keepCompletion ? existing.completedAt : null,
    );
    await _adapter.upsert(model);
    return model.toEntity();
  }

  @override
  Future<FocusEntity> completeToday() async {
    final key = DateUtilsX.keyOf(_now());
    final existing = await _adapter.getByKey(key);
    if (existing == null) {
      throw const AppFailure('Defina um foco antes de concluir.');
    }
    if (existing.completed) return existing.toEntity();
    final model = FocusModel(
      dateKey: key,
      title: existing.title,
      completed: true,
      completedAt: _now(),
    );
    await _adapter.upsert(model);
    return model.toEntity();
  }

  @override
  Future<List<FocusEntity>> entriesBetween(DateTime start, DateTime end) async {
    final models = await _adapter.range(
      DateUtilsX.keyOf(start),
      DateUtilsX.keyOf(end),
    );
    return models.map((m) => m.toEntity()).toList();
  }
}
