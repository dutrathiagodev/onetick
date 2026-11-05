import '../../auth/repositories/auth_repository.dart';
import '../repositories/settings_repository.dart';

/// "Excluir conta": erases the user's data and then the account itself.
class DeleteAccountUseCase {
  const DeleteAccountUseCase(this._auth, this._settings);

  final AuthRepository _auth;
  final SettingsRepository _settings;

  Future<void> call() async {
    // Checked first so a refused deletion never leaves the account empty.
    await _auth.ensureCanDeleteAccount();
    await _settings.clearHistory();
    await _settings.deletePreferences();
    await _auth.deleteAccount();
  }
}
