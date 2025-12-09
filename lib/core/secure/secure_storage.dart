import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// An abstract interface for secure storage operations.
///
/// Provides methods to write, read, delete, and clear key-value pairs
/// in a secure storage mechanism, such as encrypted local storage.
///
/// Implementations of this interface should ensure that all data is
/// stored securely and that sensitive information is protected.
abstract class ISecureStorageService {
  /// Writes a [value] associated with the given [key] to secure storage.
  ///
  /// If the [key] already exists, its value will be overwritten.
  Future<void> write(String key, String value);

  /// Reads the value associated with the given [key] from secure storage.
  ///
  /// Returns the value if it exists, or `null` if the [key] is not found.
  Future<String?> read(String key);

  /// Deletes the value associated with the given [key] from secure storage.
  Future<void> delete(String key);

  /// Deletes all key-value pairs from secure storage.
  Future<void> deleteAll();
}

class SecureStorage implements ISecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorage(this._storage);

  @override
  Future<void> write(String key, String value) async {
    await _storage.write(
      key: key,
      value: value,
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );
  }

  @override
  Future<String?> read(String key) async {
    return await _storage.read(
      key: key,
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );
  }

  @override
  Future<void> delete(String key) async {
    await _storage.delete(
      key: key,
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );
  }

  @override
  Future<void> deleteAll() async {
    await _storage.deleteAll(
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );
  }
}
