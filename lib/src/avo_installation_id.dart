import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AvoInstallationId {
  String? _installationId;

  static const installationIdKey = "FlutterAvoInspectorInstallationId";

  String getInstallationId(SharedPreferences sharedPrefs) {
    if (_installationId != null) {
      return _installationId!;
    }

    final storedInstallationId = sharedPrefs.getString(installationIdKey);

    if (storedInstallationId != null) {
      _installationId = storedInstallationId;
      return storedInstallationId;
    } else {
      final newInstallationId = const Uuid().v1();
      _installationId = newInstallationId;
      sharedPrefs.setString(
          AvoInstallationId.installationIdKey, newInstallationId);
      return newInstallationId;
    }
  }
}
