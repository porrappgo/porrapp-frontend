import 'package:flutter_test/flutter_test.dart';
import 'package:porrapp_frontend/features/auth/domain/model/auth_model.dart';

void main() {
  group('AuthModel', () {
    test('creates AuthModel from JSON string', () {
      const jsonString = '''
      {
        "email": "test@test.com",
        "name": "Test User"
      }
      ''';

      final model = authModelFromJson(jsonString);

      expect(model.email, 'test@test.com');
      expect(model.name, 'Test User');
    });

    test('converts AuthModel to JSON string', () {
      final model = AuthModel(email: 'test@test.com', name: 'Test User');

      final jsonString = authModelToJson(model);

      expect(jsonString, '{"email":"test@test.com","name":"Test User"}');
    });

    test('creates AuthModel from JSON map', () {
      final jsonMap = {'email': 'john@doe.com', 'name': 'John Doe'};

      final model = AuthModel.fromJson(jsonMap);

      expect(model.email, 'john@doe.com');
      expect(model.name, 'John Doe');
    });

    test('converts AuthModel to JSON map', () {
      final model = AuthModel(email: 'john@doe.com', name: 'John Doe');

      final jsonMap = model.toJson();

      expect(jsonMap, {'email': 'john@doe.com', 'name': 'John Doe'});
    });

    test('JSON round-trip preserves data', () {
      final original = AuthModel(email: 'round@trip.com', name: 'Round Trip');

      final jsonString = authModelToJson(original);
      final restored = authModelFromJson(jsonString);

      expect(restored.email, original.email);
      expect(restored.name, original.name);
    });
  });
}
