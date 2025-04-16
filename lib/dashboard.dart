import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = '';

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  Future<void> fetchUserName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      setState(() {
        userName = doc['firstName'] ?? '';
      });
    }
  }

  final List<Map<String, dynamic>> messageBoards = [
    {'name': 'General Discussion', 'icon': Icons.chat},
    {'name': 'Announcements', 'icon': Icons.announcement},
    {'name': 'Sports Talk', 'icon': Icons.sports},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Message Boards")),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome, $userName", style: TextStyle(color: Colors.white, fontSize: 22)),
                  SizedBox(height: 10),
                  Text("Menu", style: TextStyle(color: Colors.white70, fontSize: 16)),
                ],
              ),
            ),
            ListTile(leading: Icon(Icons.message), title: Text("Message Boards"), onTap: () => Navigator.pop(context)),
            ListTile(leading: Icon(Icons.person), title: Text("Profile"), onTap: () => Navigator.pushNamed(context, '/profile')),
            ListTile(leading: Icon(Icons.settings), title: Text("Settings"), onTap: () => Navigator.pushNamed(context, '/settings')),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: messageBoards.length,
        itemBuilder: (context, index) {
          final board = messageBoards[index];
          return ListTile(
            leading: Icon(board['icon'], size: 40, color: Colors.blue),
            title: Text(board['name']),
            onTap: () => Navigator.pushNamed(context, '/chat', arguments: board['name']),
          );
        },
      ),
    );
  }
}
