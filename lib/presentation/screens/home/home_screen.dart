import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Gemini'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.pink,
              child: Icon(Icons.person_outlined),
            ),
            title: Text('Prompt básico a Gemini'),
            subtitle: Text('Usando un modelo flash'),
            onTap: () => context.push('/basic-prompt'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurple,
              child: Icon(Icons.history_outlined),
            ),
            title: Text('Chat conversacional'),
            subtitle: Text('Manteniedo el contexto de mensajes'),
            onTap: () => context.push('/history-chat'),
          ),
          // Add more ListTiles for other features
        ],
      )
    );
  }
}