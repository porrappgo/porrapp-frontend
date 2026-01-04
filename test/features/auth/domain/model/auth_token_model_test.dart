import 'package:flutter_test/flutter_test.dart';
import 'package:porrapp_frontend/features/auth/domain/model/auth_token_model.dart';

void main() {
  group('AuthTokenModel', () {
    test('creates AuthTokenModel from JSON string', () {
      const jsonString = '''
      {
        "access": "access_token",
        "refresh": "refresh_token"
      }
      ''';

      final model = authTokenModelFromJson(jsonString);

      expect(model.access, 'access_token');
      expect(model.refresh, 'refresh_token');
    });

    test('creates AuthTokenModel from JSON string with null refresh', () {
      const jsonString = '''
      {
        "access": "access_token",
        "refresh": null
      }
      ''';

      final model = authTokenModelFromJson(jsonString);

      expect(model.access, 'access_token');
      expect(model.refresh, isNull);
    });

    test('converts AuthTokenModel to JSON string', () {
      final model = AuthTokenModel(
        access: 'access_token',
        refresh: 'refresh_token',
      );

      final jsonString = authTokenModelToJson(model);

      expect(jsonString, '{"access":"access_token","refresh":"refresh_token"}');
    });

    test('converts AuthTokenModel with null refresh to JSON string', () {
      final model = AuthTokenModel(access: 'access_token', refresh: null);

      final jsonString = authTokenModelToJson(model);

      expect(jsonString, '{"access":"access_token","refresh":null}');
    });

    test('creates AuthTokenModel from JSON map', () {
      final jsonMap = {'access': 'access_token', 'refresh': 'refresh_token'};

      final model = AuthTokenModel.fromJson(jsonMap);

      expect(model.access, 'access_token');
      expect(model.refresh, 'refresh_token');
    });

    test('creates AuthTokenModel from JSON map with null refresh', () {
      final jsonMap = {'access': 'access_token', 'refresh': null};

      final model = AuthTokenModel.fromJson(jsonMap);

      expect(model.access, 'access_token');
      expect(model.refresh, isNull);
    });

    test('converts AuthTokenModel to JSON map', () {
      final model = AuthTokenModel(
        access: 'access_token',
        refresh: 'refresh_token',
      );

      final jsonMap = model.toJson();

      expect(jsonMap, {'access': 'access_token', 'refresh': 'refresh_token'});
    });

    test('converts AuthTokenModel with null refresh to JSON map', () {
      final model = AuthTokenModel(access: 'access_token', refresh: null);

      final jsonMap = model.toJson();

      expect(jsonMap, {'access': 'access_token', 'refresh': null});
    });

    test('JSON round-trip preserves data', () {
      final original = AuthTokenModel(
        access: 'access_token',
        refresh: 'refresh_token',
      );

      final jsonString = authTokenModelToJson(original);
      final restored = authTokenModelFromJson(jsonString);

      expect(restored.access, original.access);
      expect(restored.refresh, original.refresh);
    });

    test('JSON round-trip preserves data with null refresh', () {
      final original = AuthTokenModel(access: 'access_token', refresh: null);

      final jsonString = authTokenModelToJson(original);
      final restored = authTokenModelFromJson(jsonString);

      expect(restored.access, original.access);
      expect(restored.refresh, isNull);
    });
  });
}
