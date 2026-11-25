/// Base URL of the Django REST Framework backend.
///
/// Defaults to `http://10.0.2.2:8000` untuk Android Emulator.
/// Override pakai `--dart-define=API_BASE_URL=http://localhost:8000` kalau run di Chrome.
const String apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://10.0.2.2:8000',
);
