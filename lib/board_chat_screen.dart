import 'package:flutter/material.dart';

class BoardChatView extends StatefulWidget {
  final String boardName;

  const BoardChatView({required this.boardName});

  @override
  _BoardChatViewState createState() => _BoardChatViewState();
}

class _BoardChatViewState extends State<BoardChatView> {
  final TextEditingController _messageController = TextEditingController();

  List<String> dummyMessages = [
    "Hi everyone!",
    "Welcome to ${DateTime.now().year}'s chat.",
    "Feel free to post questions or updates."
  ];

  void sendMessage() {
    final msg = _messageController.text.trim();
    if (msg.isNotEmpty) {
      setState(() {
        dummyMessages.add(msg);
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.boardName),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: dummyMessages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(dummyMessages[index]),
                  ),
                );
              },
            ),
          ),
          Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send),
                  color: Colors.blue,
                  onPressed: sendMessage,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
