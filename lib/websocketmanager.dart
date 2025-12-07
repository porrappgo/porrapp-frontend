import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketManager {
  final String url;
  WebSocketChannel? _channel;

  bool isConnected = false;
  Timer? _reconnectTimer;
  Timer? _pingTimer;

  int missedPongs = 0;

  final StreamController<String> _messagesController =
      StreamController.broadcast();

  Stream<String> get messages => _messagesController.stream;

  WebSocketManager(this.url);

  void connect() {
    try {
      print("🔌 Intentando conectar a $url...");
      _channel = WebSocketChannel.connect(Uri.parse(url));

      _channel!.stream.listen(
        (data) {
          final decoded = jsonDecode(data);

          // 🔥 Manejo del PONG
          if (decoded["pong"] == true) {
            missedPongs = 0; // reset
            if (!isConnected) print("🟢 Reconexion efectiva");
            isConnected = true;
            return;
          }

          // 🔥 Notificación de conexión
          if (decoded["status"] == "connected") {
            isConnected = true;
            missedPongs = 0;
            print("🟢 Conectado");
          }

          _messagesController.add(data);
        },
        onDone: _handleDisconnect,
        onError: (_) => _handleDisconnect(),
      );

      // Iniciar envío periódico de ping desde Flutter
      _startPingTimer();
    } catch (e) {
      print("❌ Error al conectar: $e");
      _handleDisconnect();
    }
  }

  void _handleDisconnect() {
    if (isConnected) print("🔴 Conexión perdida");

    isConnected = false;
    missedPongs = 999;

    _pingTimer?.cancel();

    if (_reconnectTimer != null && _reconnectTimer!.isActive) return;

    _reconnectTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      print("🔁 Reintentando conexión...");
      connect();
      if (isConnected) timer.cancel();
    });
  }

  void _startPingTimer() {
    _pingTimer?.cancel();

    _pingTimer = Timer.periodic(Duration(seconds: 10), (_) {
      if (!isConnected) return;

      missedPongs++;

      if (missedPongs >= 2) {
        print("❌ No se reciben PONGs → marcando desconectado");
        _handleDisconnect();
        return;
      }

      sendJson({"ping": true});
    });
  }

  void sendJson(Map<String, dynamic> data) {
    if (isConnected) {
      _channel?.sink.add(jsonEncode(data));
    } else {
      print("⚠️ No se puede enviar, desconectado");
    }
  }

  void dispose() {
    _channel?.sink.close();
    _messagesController.close();
    _pingTimer?.cancel();
    _reconnectTimer?.cancel();
  }
}
