// ignore_for_file: constant_identifier_names

enum StorageManagerKey {
  TIRINI_UUID,
  TOKEN,
  AHANDA,
}

extension StorageManagerKeyExtension on StorageManagerKey {
  String get rawValue {
    switch (this) {
      case StorageManagerKey.TOKEN:
        return 'TOKEN';
      case StorageManagerKey.AHANDA:
        return 'AHANDA';
      case StorageManagerKey.TIRINI_UUID:
        return 'TIRINI_UUID';
    }
  }
}
