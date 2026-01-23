import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:porrapp_frontend/core/util/share_dialog.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel(
    'dev.fluttercommunity.plus/share',
  );

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'share') {
        return 'success';
      }
      return null;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('shares text when only text is provided', () async {
    // Arrange
    final text = 'Test text';
    // Act
    final result = await showShareDialog(text: text);
    // Assert
    expect(result, isNotNull);
  });

  test('shares URI when only URI is provided', () async {
    // Arrange
    final uri = Uri.parse('https://example.com');
    // Act
    final result = await showShareDialog(uri: uri);
    // Assert
    expect(result, isNotNull);
  });

  test('shares combined text and URI when both are provided', () async {
    // Arrange
    final text = 'Check this';
    final uri = Uri.parse('https://example.com');
    // Act
    final result = await showShareDialog(text: text, uri: uri);
    // Assert
    expect(result, isNotNull);
  });

  test('throws ArgumentError when neither text nor URI is provided', () async {
    // Arrange
    // Act & Assert
    expect(() => showShareDialog(), throwsA(isA<ArgumentError>()));
  });

  test('error message is in Spanish', () async {
    // Arrange
    // Act & Assert
    expect(
      () => showShareDialog(),
      throwsA(
        isA<ArgumentError>().having(
          (e) => e.message,
          'message',
          contains('Debe proporcionar'),
        ),
      ),
    );
  });
}
