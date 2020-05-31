import 'package:flutter/material.dart';

void main() {
  runApp(VoteApp());
}

class VoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Vote!'),
        ),
      ),
    );
  }
}
