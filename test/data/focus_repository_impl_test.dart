import 'package:flutter_test/flutter_test.dart';
import 'package:onetick/core/failures.dart';
import 'package:onetick/data/focus/repositories/focus_repository_impl.dart';
import 'package:onetick/infra/adapters/focus/in_memory_focus_adapter.dart';

import '../helpers/test_setup.dart';

void main() {
  late InMemoryFocusAdapter adapter;
  late FocusRepositoryImpl repository;
  var now = testNow;

  setUp(() {
    now = testNow;
    adapter = InMemoryFocusAdapter();
    repository = FocusRepositoryImpl(adapter, () => now);
  });

  test('getToday is null until a focus is saved', () async {
    expect(await repository.getToday(), isNull);
    await repository.saveToday('Ler 10 páginas');
    final today = await repository.getToday();
    expect(today?.title, 'Ler 10 páginas');
    expect(today?.dateKey, '2024-10-30');
    expect(today?.completed, isFalse);
  });

  test('completeToday marks completed with timestamp', () async {
    await repository.saveToday('Meditar');
    final done = await repository.completeToday();
    expect(done.completed, isTrue);
    expect(done.completedAt, testNow);
  });

  test('completeToday is idempotent', () async {
    await repository.saveToday('Meditar');
    final first = await repository.completeToday();
    now = testNow.add(const Duration(hours: 2));
    final second = await repository.completeToday();
    expect(second.completedAt, first.completedAt);
  });

  test('completeToday without focus fails', () async {
    expect(repository.completeToday(), throwsA(isA<AppFailure>()));
  });

  test(
    'replacing the focus resets completion; re-saving same text keeps it',
    () async {
      await repository.saveToday('A');
      await repository.completeToday();
      expect((await repository.saveToday('A')).completed, isTrue);
      expect((await repository.saveToday('B')).completed, isFalse);
    },
  );

  test('entriesBetween is inclusive', () async {
    for (final d in [28, 29, 30]) {
      await adapter.upsert(focusOn(DateTime(2024, 10, d), 'd$d'));
    }
    final list = await repository.entriesBetween(
      DateTime(2024, 10, 29),
      DateTime(2024, 10, 30),
    );
    expect(
      list.map((e) => e.dateKey),
      unorderedEquals(['2024-10-29', '2024-10-30']),
    );
  });
}
