import 'package:flutter/material.dart';
import 'package:porrapp_frontend/websocketmanager.dart';

class WebSocketTestPage extends StatefulWidget {
  static const String routeName = "websocket_test";

  const WebSocketTestPage({super.key});

  @override
  State<WebSocketTestPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<WebSocketTestPage> {
  late WebSocketManager ws;
  final TextEditingController _controller = TextEditingController();
  final List<String> messages = [];

  @override
  void initState() {
    super.initState();

    ws = WebSocketManager("ws://192.168.1.14:8000/ws/chat/general/");
    ws.connect();

    ws.messages.listen((msg) {
      setState(() {
        messages.add(msg);
      });
    });
  }

  void sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final jsonMsg = {"message": "$text"};
    ws.sendJson(jsonMsg);

    _controller.clear();
  }

  @override
  void dispose() {
    ws.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              ws.isConnected ? Icons.circle : Icons.circle_outlined,
              color: ws.isConnected ? Colors.green : Colors.red,
              size: 14,
            ),
            const SizedBox(width: 8),
            Text(ws.isConnected ? "Conectado" : "Desconectado"),
          ],
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (_, i) {
                return ListTile(title: Text(messages[i]));
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            color: Colors.grey[200],
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Escribe un mensaje",
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
