import '../../../infra/adapters/focus/firestore_focus_adapter.dart';
import '../../../infra/adapters/focus/focus_remote_adapter.dart';
import '../../../infra/adapters/focus/in_memory_focus_adapter.dart';
import '../service_locator.dart';
import 'auth_dependencies.dart';

/// The focus adapter is shared by the today, define-focus, history and
/// settings screens, so it is registered once from here.
void setupFocusAdapterDependencies() {
  setupAuthDependencies();
  if (!getIt.isRegistered<FocusRemoteAdapter>()) {
    getIt.registerLazySingleton<FocusRemoteAdapter>(
      () => getIt<AppConfig>().useFirebase
          ? FirestoreFocusAdapter(uidProvider: currentUserId)
          : InMemoryFocusAdapter(),
    );
  }
}
