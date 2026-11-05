import 'package:flutter_test/flutter_test.dart';
import 'package:onetick/main/di/service_locator.dart';
import 'package:onetick/presenter/today/today_cubit.dart';
import 'package:onetick/presenter/today/today_state.dart';

import '../helpers/test_setup.dart';

void main() {
  late MutableClock clock;
  late TodayCubit cubit;

  setUp(() async {
    clock = MutableClock(DateTime(2024, 10, 30, 23, 50));
    await setUpTestDependencies(
      signedInUser: testUser,
      clock: clock,
      focus: [focusOn(DateTime(2024, 10, 30), 'Ler 10 páginas')],
    );
    cubit = getIt<TodayCubit>();
    await cubit.load();
  });

  tearDown(() => cubit.close());

  test('shows the new day after midnight instead of yesterday', () async {
    expect(cubit.state, isA<TodayCompleted>());

    clock.value = DateTime(2024, 10, 31, 0, 0, 5);
    await cubit.refreshIfNewDay();

    expect(cubit.state, isA<TodayEmpty>());
  });

  test('same day does not reload', () async {
    final before = cubit.state;
    clock.value = DateTime(2024, 10, 30, 23, 59);
    await cubit.refreshIfNewDay();

    expect(identical(cubit.state, before), isTrue);
  });
}
