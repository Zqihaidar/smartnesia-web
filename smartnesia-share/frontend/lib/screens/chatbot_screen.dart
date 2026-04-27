import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [
    {"role": "bot", "text": "Halo Budi, ada yang bisa kami bantu hari ini? Kami dapat membantu mencari informasi layanan publik, rekomendasi wisata, hingga pengecekan tiket secara real-time."},
  ];
  bool _isLoading = false;

  Future<void> _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;

    final userText = _controller.text;
    setState(() {
      _messages.add({"role": "user", "text": userText});
      _controller.clear();
      _isLoading = true;
    });

    try {
      // Connect to Azure Functions local backend
      // Gunakan 10.0.2.2 untuk Android Emulator, localhost untuk Desktop/Web
      String baseUrl = 'http://10.0.2.2:7071';
      try {
        if (Theme.of(context).platform == TargetPlatform.windows || 
            Theme.of(context).platform == TargetPlatform.linux || 
            Theme.of(context).platform == TargetPlatform.macOS) {
          baseUrl = 'http://localhost:7071';
        }
      } catch (e) {
        // Ignore platform check error if web
      }

      final response = await http.post(
        Uri.parse('$baseUrl/api/ChatbotWebhook'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': userText}),
      ).timeout(const Duration(seconds: 15)); // Tambahkan timeout agar tidak muter terus

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _messages.add({"role": "bot", "text": data['response']});
        });
      } else {
        setState(() {
          _messages.add({"role": "bot", "text": "Maaf, server merespons dengan error: ${response.statusCode}"});
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({"role": "bot", "text": "Maaf, tidak dapat terhubung ke server. Pastikan backend berjalan ($e)."});
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.blueAccent,
              child: Icon(Icons.smart_toy, color: Colors.white),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('SmartNesia AI', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16)),
                Row(
                  children: [
                    Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                    const SizedBox(width: 4),
                    const Text('Online', style: TextStyle(color: Colors.green, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg["role"] == "user";
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      color: isUser ? const Color(0xFF1E5BB2) : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(20),
                        topRight: const Radius.circular(20),
                        bottomLeft: isUser ? const Radius.circular(20) : Radius.zero,
                        bottomRight: isUser ? Radius.zero : const Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.shade200, blurRadius: 5),
                      ],
                    ),
                    child: Text(
                      msg["text"]!,
                      style: TextStyle(color: isUser ? Colors.white : Colors.black87),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(color: Colors.white),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Ketik pesan Anda...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: const BoxDecoration(
                      color: Color(0xFF1E5BB2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
