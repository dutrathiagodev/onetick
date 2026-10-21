/// Injectable clock so "today" is deterministic in tests.
class AppClock {
  const AppClock();

  DateTime now() => DateTime.now();
}
