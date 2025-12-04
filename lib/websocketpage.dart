import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketTestPage extends StatefulWidget {
  @override
  _WebSocketTestPageState createState() => _WebSocketTestPageState();
}

class _WebSocketTestPageState extends State<WebSocketTestPage> {
  late WebSocketChannel channel;
  String receivedMsg = "";

  @override
  void initState() {
    super.initState();

    channel = WebSocketChannel.connect(
      Uri.parse("ws://192.168.1.14:8000/ws/chat/general/"),
    );

    channel.stream.listen((message) {
      print("Mensaje recibido: $message");
      setState(() {
        receivedMsg = message;
      });
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("WebSocket Test")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Status connection
            Row(
              children: [
                const Text("Estado de la conexión: "),
                Icon(
                  channel.closeCode == null ? Icons.check_circle : Icons.error,
                  color: channel.closeCode == null ? Colors.green : Colors.red,
                ),
              ],
            ),
            Text("Último mensaje recibido:"),
            Text(
              receivedMsg,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: "Mensaje a enviar"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              child: const Text("Enviar"),
              onPressed: () {
                channel.sink.add(controller.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
